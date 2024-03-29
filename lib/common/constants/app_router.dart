import 'package:charity_cashier/presentation/dashboard/dashboard_page.dart';
import 'package:charity_cashier/presentation/register/register_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/login/login_page.dart';
import '../../presentation/splashscreen/splashscreen_page.dart';
import 'route_constant.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstants.splashscreen:
        return MaterialPageRoute(
          builder: (_) => const SplashscreenPage(),
        );
      case RouteConstants.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case RouteConstants.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      case RouteConstants.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Center(child: Text("Something wrong")),
        );
    }
  }
}
