
import 'package:agung_opr/application/check_sheet/unloading/view/check_sheet_unloading_page.dart';
import 'package:agung_opr/application/cranny/view/cranny_page.dart';
import 'package:agung_opr/application/customer/view/customer_page.dart';
import 'package:agung_opr/application/model/view/model_page.dart';
import 'package:agung_opr/application/spk/view/spk_page.dart';
import 'package:agung_opr/application/spk/view/spk_scan.dart';
import 'package:agung_opr/application/supir/view/supir_page.dart';
import 'package:agung_opr/application/update_frame/view/update_frame_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/providers.dart';

import '../auth/auth_notifier.dart';
import '../auto_data/view/data_update_query_page.dart';
import '../check_sheet/loading/view/check_sheet_loading_page.dart';
import '../check_sheet/unit/view/csu_new_page.dart';
import '../check_sheet/unit/view/csu_result_page.dart';
import '../profile/profile_page.dart';
import '../sign_in_form/view/sign_in_page.dart';
import '../spk/spk.dart';
import '../tc/shared/tc_providers.dart';
import '../tc/tc_page.dart';
import '../tc/tc_state.dart';
import '../update_frame/frame.dart';
import 'route_names.dart';

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authNotifierProvider,
      (_, __) => notifyListeners(),
    );

    _ref.listen<TCState>(
      tcNotifierProvider,
      (_, __) => notifyListeners(),
    );
  }

  final Ref _ref;

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authNotifierProvider);
    final tcState = _ref.read(tcNotifierProvider);

    final areWeSigningIn = state.matchedLocation == RouteNames.signInRoute;
    final areWeReadingTC =
        state.matchedLocation == RouteNames.termsAndConditionRoute;

    final weVisitedTC = tcState == TCState.visited();

    return authState.maybeMap(
      authenticated: (_) {
        if (areWeSigningIn && weVisitedTC) {
          //

          return RouteNames.crannyName;
        } else if (areWeSigningIn && !weVisitedTC) {
          //

          return RouteNames.termsAndConditionNameRoute;
        } else if (areWeReadingTC && weVisitedTC) {
          //

          return RouteNames.crannyName;
        }
        return null;
      },
      orElse: () => areWeSigningIn ? null : RouteNames.signInRoute,
    );
  }

  List<GoRoute> get routes {
    return [
      GoRoute(
        name: RouteNames.termsAndConditionNameRoute,
        path: RouteNames.termsAndConditionRoute,
        builder: (context, state) => TCPage(),
      ),
      GoRoute(
        name: RouteNames.crannyNameRoute,
        path: RouteNames.crannyName,
        builder: (context, state) => const CrannyPage(),
      ),
      GoRoute(
          name: RouteNames.signInNameRoute,
          path: RouteNames.signInRoute,
          builder: (context, state) => const SignInPage(),
          routes: [
            GoRoute(
              name: RouteNames.spkNameRoute,
              path: RouteNames.spkName,
              builder: (context, state) => SPKPage(),
            ),
            GoRoute(
              name: RouteNames.modelNameRoute,
              path: RouteNames.modelName,
              builder: (context, state) => ModelPage(),
            ),
            GoRoute(
              name: RouteNames.customerNameRoute,
              path: RouteNames.customerName,
              builder: (context, state) => CustomerPage(),
            ),
            GoRoute(
              name: RouteNames.supirName,
              path: RouteNames.supirNameRoute,
              builder: (context, state) => SupirPage(),
            ),
            GoRoute(
              name: RouteNames.scanSPKNameRoute,
              path: RouteNames.scanSPKRoute,
              builder: (context, state) => SPKScan(),
            ),
            GoRoute(
              name: RouteNames.updateFrameNameRoute,
              path: RouteNames.updateFrameName,
              builder: (context, state) {
                int idSPK = state.extra as int;
                return UpdateFramePage(idSPK: idSPK);
              },
            ),
            GoRoute(
                name: RouteNames.CSUListNameRoute,
                path: RouteNames.CSUListName,
                builder: (context, state) {
                  Frame item = state.extra as Frame;
                  return CSUResultPage(frame: item);
                }),
            GoRoute(
                name: RouteNames.CSUNewNameRoute,
                path: RouteNames.CSUNewName,
                builder: (context, state) {
                  int idCS = state.extra as int;
                  return CSUNewPage(idCS: idCS);
                }),
            GoRoute(
              name: RouteNames.checkSheetLoadingNameRoute,
              path: RouteNames.checkSheetLoadingName,
              builder: (context, state) {
                SPK spk = state.extra as SPK;
                return CheckSheetLoadingPage(spk: spk);
              },
            ),
            GoRoute(
              name: RouteNames.checkSheetUnloadingNameRoute,
              path: RouteNames.checkSheetUnloadingName,
              builder: (context, state) => CheckSheetUnloadingPage(),
            ),
            GoRoute(
              name: RouteNames.profileNameRoute,
              path: RouteNames.profileRoute,
              builder: (context, state) => const ProfilePage(),
            ),
            GoRoute(
              name: RouteNames.dataUpdateQueryName,
              path: RouteNames.dataUpdateQueryNameRoute,
              builder: (context, state) => DataUpdateQueryPage(),
            ),
          ]),
    ];
  }
}
