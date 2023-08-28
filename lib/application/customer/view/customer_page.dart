import 'dart:developer';

import 'package:agung_opr/application/customer/customer.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import '../shared/customer_providers.dart';
import 'customer_scaffold.dart';

class CustomerPage extends ConsumerStatefulWidget {
  const CustomerPage();

  @override
  ConsumerState<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends ConsumerState<CustomerPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final customerOfflineOrOnline =
          ref.watch(customerOfflineNotifierProvider);

      log('customerOfflineOrOnline $customerOfflineOrOnline');

      // debugger(message: 'called');

      await customerOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(customerNotifierProvider.notifier)
            .getCustomerListOFFLINE(page: 0),
        orElse: () async {
          for (int i = 0; i < 5; i++) {
            await ref
                .read(customerNotifierProvider.notifier)
                .getCustomerList(page: i);
          }

          await ref
              .read(customerOfflineNotifierProvider.notifier)
              .checkAndUpdateCustomerOFFLINEStatus();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<Customer>>>>(
        customerNotifierProvider.select(
          (state) => state.FOSOCustomer,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => failure.maybeMap(
                          noConnection: (value) => ref
                              .read(isOfflineStateProvider.notifier)
                              .state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data CUSTOMER.',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              orElse: () => '',
                            ),
                          ),
                        ), (customerResponse) {
                  final oldCustomerResponse = ref
                      .read(customerNotifierProvider.notifier)
                      .state
                      .customerList;

                  final page =
                      ref.read(customerNotifierProvider.notifier).state.page;

                  ref.read(customerNotifierProvider.notifier).processModelList(
                        newCustomer: customerResponse,
                        page: page,
                        changeModel: () => ref
                            .read(customerNotifierProvider.notifier)
                            .changeCustomerList(
                                newCustomer: customerResponse,
                                oldCustomer: oldCustomerResponse),
                        replaceModel: () => ref
                            .read(customerNotifierProvider.notifier)
                            .replaceCustomerList(customerResponse),
                        changeIsMore: () => ref
                            .read(customerNotifierProvider.notifier)
                            .changeIsMore(false),
                      );
                })));

    ref.listen<Option<Either<LocalFailure, Customer>>>(
        customerNotifierProvider.select(
          (state) => state.FOSOInsertCustomer,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data INSERT CUSTOMER.',
                        empty: (_) => "Tidak ada CUSTOMER",
                        format: (value) => 'Error format $value',
                      ),
                    ),
                (customer) => context.pop(customer.id.toString()))));

    final isLoading = ref
        .watch(customerNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [CustomerScaffold(), LoadingOverlay(isLoading: isLoading)],
    );
  }
}
