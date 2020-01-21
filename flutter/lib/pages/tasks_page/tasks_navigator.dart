import 'package:flutter/material.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/router.dart';
import 'package:google_tasks/util/util.dart';
import 'package:provider/provider.dart';

import 'task_detail_page/task_detail_page.dart';
import 'tasks_page.dart';

class TasksNavigator extends StatelessWidget {
  const TasksNavigator({Key key}) : super(key: key);
  static const routeName = '/Tasks';

  static final _routes = <String, WidgetPageBuilder>{
    TasksPage.routeName: (context, settings) =>
        TasksPage.withDependencies(context),
    TaskDetailPage.routeName: (context, settings) {
      return TaskDetailPage.withDependencies(
        settings.arguments,
      );
    },
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) =>
              TasksService(authenticator: Provider.of(context, listen: false)),
        ),
      ],
      child: Navigator(
        initialRoute: TasksPage.routeName,
        onGenerateRoute: (settings) {
          logger.info('Route name: ${settings.name}');
          final pageBuilder = _routes[settings.name];
          if (settings.name == TaskDetailPage.routeName) {
            final model =
                TaskDetailPage.convertToModelFromArguments(settings.arguments);
            settings =
                settings.copyWith(name: '${settings.name}${model.doc.id}');
          }
          if (pageBuilder != null) {
            return MaterialPageRoute<void>(
              builder: (context) => pageBuilder(context, settings),
              settings: settings,
            );
          }
          logger.shout('Invalid route: ${settings.name}');
          return null;
        },
      ),
    );
  }
}
