import 'package:flutter/material.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'pages/tasks_page/tasks_page.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TasksPage.withDependencies(),
      theme: buildTheme(),
      navigatorObservers: [RouteObserverProvider.of(context)],
    );
  }
}
