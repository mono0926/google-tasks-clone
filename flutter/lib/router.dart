import 'package:flutter/material.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

import 'pages/root_page/root_page.dart';
import 'pages/tasks_page/tasks_navigator.dart';

typedef WidgetPageBuilder = Widget Function(
  BuildContext context,
  RouteSettings settings,
);

// ignore: avoid_classes_with_only_static_members
class Router {
  static final _routes = <String, WidgetPageBuilder>{
    '/': (context, settings) => RootPage.withDependencies(),
  };
  static final _fadeRoutes = <String, WidgetPageBuilder>{
    WelcomePage.routeName: (context, settings) =>
        WelcomePage.withDependencies(),
    TasksPage.routeName: (context, settings) => const TasksNavigator(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    logger.info(settings.name);
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
