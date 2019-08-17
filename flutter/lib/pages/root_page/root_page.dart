import 'package:flutter/material.dart';
import 'package:google_tasks/util/app_navigator.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class RootPage extends StatelessWidget {
  const RootPage._({Key key}) : super(key: key);
  static Widget withDependencies() {
    return Provider<Model>(
      builder: (context) => Model(
        authenticator: Provider.of(context, listen: false),
        navigatorKey: Provider.of<AppNavigator>(context, listen: false).key,
      ),
      child: const RootPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
