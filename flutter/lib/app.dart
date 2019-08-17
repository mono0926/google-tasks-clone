import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'l10n/l10n.dart';
import 'router.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(),
      navigatorObservers: [RouteObserverProvider.of(context)],
      builder: (context, child) => TextScaleFactor(child: child),
      localizationsDelegates: [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      onGenerateRoute: Router.onGenerateRoute,
    );
  }
}
