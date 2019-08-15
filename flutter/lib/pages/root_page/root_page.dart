import 'package:flutter/material.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class RootPage extends StatefulWidget {
  const RootPage._({Key key}) : super(key: key);
  static Widget withDependencies() {
    return ChangeNotifierProxyProvider<Authenticator, Model>(
      builder: (context, authenticator, model) =>
          model ??
          Model(
            authenticator: authenticator,
          ),
      child: const RootPage._(),
    );
  }

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Model get _model => Provider.of<Model>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _model.addListener(() {
      final routeName = _model.nextRouteName;
      if (routeName != null) {
        Navigator.of(context).popUntil((r) => r.isFirst);
        Navigator.of(context).pushNamed(routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
