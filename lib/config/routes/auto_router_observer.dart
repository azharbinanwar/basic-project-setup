part of 'routes.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    Log.i(runtimeType, 'New route pushed: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    Log.i(runtimeType, 'Tab route visited: ${previousRoute?.name} => ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    Log.i(runtimeType, 'Tab route re-visited: ${previousRoute.name} => ${route.name}');
  }
}
