import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/util/util.dart';
import 'package:provider/provider.dart';

import 'tasks_page.dart';

class TasksNavigator extends StatelessWidget {
  const TasksNavigator({Key key}) : super(key: key);
  static const routeName = '/Tasks';
  static const _tasksRoot = 'Tasks/';

  static final _routes = <String, WidgetBuilder>{
    _tasksRoot: (context) => TasksPage.withDependencies(),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<FirebaseUser, TasksService>(
          initialBuilder: (context) => TasksService(),
          builder: (context, firUser, tasksService) =>
              tasksService..updateFirebaseUser(firUser),
        ),
      ],
      child: Navigator(
        initialRoute: _tasksRoot,
        onGenerateRoute: (settings) {
          logger.info(settings.name);
          final pageBuilder = _routes[settings.name];
          if (pageBuilder != null) {
            return MaterialPageRoute<void>(
              builder: pageBuilder,
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
