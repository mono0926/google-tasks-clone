import 'package:flutter/material.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

import 'pages/tasks_page/task_detail_page/task_detail_page.dart';

typedef WidgetPageBuilder = Widget Function(
  BuildContext context,
  RouteSettings settings,
);

// ignore: avoid_classes_with_only_static_members
class Router {
  static final _routes = <String, WidgetPageBuilder>{
//    '/': (context, settings) => RootPage.wrapped(),
    TaskDetailPage.routeName: (context, settings) {
      return TaskDetailPage.wrapped(
        settings.arguments,
      );
    },
  };
  static final _fadeRoutes = <String, WidgetPageBuilder>{
    TasksPage.routeName: (context, settings) => TasksPage.wrapped(context),
    WelcomePage.routeName: (context, settings) => WelcomePage.wrapped(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings _settings) {
    var settings = _settings;
    logger.info(settings.name);
    var pageBuilder = _routes[settings.name];
    if (settings.name == TaskDetailPage.routeName) {
      final model =
          TaskDetailPage.convertToModelFromArguments(settings.arguments);
      settings = settings.copyWith(name: '${settings.name}${model.doc.id}');
    }
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
