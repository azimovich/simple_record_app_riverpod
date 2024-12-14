import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../future/main/view/pages/main_page.dart";
import "../../future/home/view/pages/home_page.dart";
import "../../future/home/view/pages/player_page.dart";
import "../../future/home/view/pages/record_page.dart";
import "../../future/splash/view/pages/splash_page.dart";
import "../../future/setting/view/pages/setting_page.dart";
import "app_route_names.dart";

GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();

Page<dynamic> customEachTransitionAnimation(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<Object>(
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      var begin = const Offset(1.0, 0.0); // From right
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    child: child,
  );
}

@immutable
final class AppRouter {
  const AppRouter._();

  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSetting = GlobalKey<NavigatorState>(debugLabel: 'shellSetting');

  static final _recordPage = GoRoute(
    path: AppRouteNames.recordPage,
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: (context, state) => customEachTransitionAnimation(context, state, const RecordPage()),
  );

  static final _playerPage = GoRoute(
    path: AppRouteNames.playerPage,
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: (context, state) => customEachTransitionAnimation(context, state, PlayerPage(audioPath: state.extra as String,)),
  );

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: parentNavigatorKey,
    initialLocation: AppRouteNames.splash,
    routes: <RouteBase>[
      // SPLASH
      GoRoute(
        path: AppRouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // SHELL ROUTE
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(
            navigationShell: navigationShell,
          );
        },
        parentNavigatorKey: parentNavigatorKey,
        branches: <StatefulShellBranch>[
          // HOME
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteNames.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  _recordPage,
                  _playerPage,
                ],
              ),
            ],
          ),

          // SETTING
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSetting,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteNames.setting,
                builder: (context, state) => const SettingPage(),
              ),
            ],
          ),
        ],
      )
    ],
  );
}
