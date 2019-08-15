import 'package:flutter/material.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'model.dart';

class InitialPage extends StatefulWidget {
  const InitialPage._({Key key}) : super(key: key);
  static Widget withDependencies() {
    return ChangeNotifierProxyProvider<Authenticator, Model>(
      builder: (context, authenticator, model) =>
          model ??
          Model(
            authenticator: authenticator,
          ),
      child: const InitialPage._(),
    );
  }

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with RouteAware, RouteObserverMixin {
  Model get _model => Provider.of<Model>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _model.addListener(() {
      final routeName = _model.nextRouteName;
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void didPopNext() {
    _model.decideNextRoute();
  }
}
