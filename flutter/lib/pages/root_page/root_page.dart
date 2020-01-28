import 'package:flutter/material.dart';
import 'package:google_tasks/util/app_navigator.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class RootPage extends StatelessWidget {
  const RootPage._({Key key}) : super(key: key);
  static Widget wrapped() {
    return Provider<Model>(
      create: (context) => Model(
        authenticator: Provider.of(context, listen: false),
        navigator: Provider.of<AppNavigator>(context, listen: false),
      ),
      lazy: false,
      child: const RootPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // 一瞬で済むなら以下は空でも良い(あるいはスプラッシュ系の表示)
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
