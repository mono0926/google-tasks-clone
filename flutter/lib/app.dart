import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_tasks/pages/root_page/root_page.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'l10n/l10n.dart';
import 'router.dart';
import 'theme.dart';
import 'util/util.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Provider.of<AppNavigator>(context).key,
      theme: buildTheme(),
      darkTheme: ThemeData.dark(),
      navigatorObservers: [RouteObserverProvider.of(context)],
      builder: (context, child) => TextScaleFactor(child: child),
      localizationsDelegates: [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      onGenerateRoute: Router.onGenerateRoute,
      home: RootPage.wrapped(),
    );
  }
}
