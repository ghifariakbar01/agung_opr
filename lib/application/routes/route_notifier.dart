import 'package:agung_opr/application/cranny/view/cranny_page.dart';
import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/model/view/model_page.dart';
import 'package:agung_opr/application/spk/view/spk_page.dart';

import 'package:agung_opr/application/supir/view/supir_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/providers.dart';

import '../auth/auth_notifier.dart';
import '../auto_data/view/data_update_query_page.dart';
import '../check_sheet/loading/view/check_sheet_loading_page.dart';
import '../check_sheet/unit/view/csu_new_page.dart';
import '../check_sheet/unit/view/csu_result_page.dart';
import '../copyright/copyright_page.dart';
import '../gate/view/gate_page.dart';
import '../history/view/history_page.dart';
import '../profile/profile_page.dart';
import '../sign_in_form/view/sign_in_page.dart';
import '../spk/spk.dart';
import '../tc/shared/tc_providers.dart';
import '../tc/tc_page.dart';
import '../tc/tc_state.dart';
import '../unit/view/unit_page.dart';
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
    final areWeInCSLoading =
        state.matchedLocation == RouteNames.checkSheetLoadingNameRoute;

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
        } else if (areWeInCSLoading) {
          this
              ._ref
              .read(modeNotifierProvider.notifier)
              .changeModeAplikasi(ModeState.checkSheetLoading());
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
              name: RouteNames.gateNameRoute,
              path: RouteNames.gateName,
              builder: (context, state) => GatePage(),
            ),
            GoRoute(
              name: RouteNames.modelNameRoute,
              path: RouteNames.modelName,
              builder: (context, state) => ModelPage(),
            ),
            GoRoute(
              path: RouteNames.supirNameRoute,
              name: RouteNames.supirName,
              builder: (context, state) => SupirPage(),
            ),
            GoRoute(
              name: RouteNames.checkSheetLoadingNameRoute,
              path: RouteNames.checkSheetLoadingName,
              builder: (context, state) {
                Map<String, dynamic> spkMap =
                    state.extra as Map<String, dynamic>;
                SPK spk = SPK.fromJson(spkMap);
                return CheckSheetLoadingPage(spk: spk);
              },
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
            GoRoute(
              name: RouteNames.historyName,
              path: RouteNames.historyNameRoute,
              builder: (context, state) => HistoryPage(),
            ),
            GoRoute(
              name: RouteNames.copyrightNameRoute,
              path: RouteNames.copyrightRoute,
              builder: (context, state) => CopyRightPage(),
            ),
            GoRoute(
              name: RouteNames.unitNameRoute,
              path: RouteNames.unitName,
              builder: (context, state) => UnitPage(),
            ),
            GoRoute(
                name: RouteNames.CSUResultNameRoute,
                path: RouteNames.CSUResultRoute,
                builder: (context, state) {
                  Map<String, dynamic> frameMap =
                      state.extra as Map<String, dynamic>;

                  Frame item = Frame.fromJson(frameMap);
                  return CSUResultPage(frame: item);
                }),
            GoRoute(
                name: RouteNames.CSUNewNameRoute,
                path: RouteNames.CSUNewName,
                builder: (context, state) {
                  int idCS = state.extra as int;
                  return CSUNewPage(idCS: idCS);
                }),
          ]),
    ];
  }
}
