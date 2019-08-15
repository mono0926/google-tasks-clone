import 'package:flutter/material.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:mono_kit/mono_kit.dart';

class Router {
  static const root = '/';

  final _routes = <String, Widget Function(BuildContext, RouteSettings)>{
//    root: (context, settings) => const ListPage(),
//    WelcomePage.routeName: (context, settings) => const WelcomePage(),
//    TasksPage.routeName: (context, settings) => TasksPage.withDependencies(),
  };
  final _fadeRoutes = <String, Widget Function(BuildContext, RouteSettings)>{
//    root: (context, settings) => const ListPage(),
    WelcomePage.routeName: (context, settings) =>
        WelcomePage.withDependencies(),
    TasksPage.routeName: (context, settings) => TasksPage.withDependencies(),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var pageBuilder = _routes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: (context) => pageBuilder(context, settings),
        settings: settings,
      );
    }
    pageBuilder = _fadeRoutes[settings.name];
    if (pageBuilder != null) {
      return FadePageRoute<void>(
        builder: (context) => pageBuilder(context, settings),
        settings: settings,
      );
    }

    assert(false, 'unexpected settings: $settings');
    return null;
  }
}
