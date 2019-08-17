import 'package:flutter/material.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

import 'pages/root_page/root_page.dart';
import 'pages/tasks_page/tasks_navigator.dart';

// ignore: avoid_classes_with_only_static_members
class Router {
  static const root = '/';

  static final _routes = <String, WidgetBuilder>{
    root: (context) => RootPage.withDependencies(),
  };
  static final _fadeRoutes = <String, WidgetBuilder>{
    WelcomePage.routeName: (context) => WelcomePage.withDependencies(),
    TasksPage.routeName: (context) => const TasksNavigator(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    logger.info(settings.name);
    var pageBuilder = _routes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: pageBuilder,
        settings: settings,
      );
    }
    pageBuilder = _fadeRoutes[settings.name];
    if (pageBuilder != null) {
      return FadePageRoute<void>(
        builder: pageBuilder,
        settings: settings,
      );
    }

    assert(false, 'unexpected settings: $settings');
    return null;
  }
}
