import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/util/util.dart';

import 'app.dart';
import 'model/notifier/notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final originalFlutterError = FlutterError.onError;
  FlutterError.onError = (error) {
    originalFlutterError(error);
    Crashlytics.instance.recordFlutterError(error);
  };
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AppNavigator()),
        RouteObserverProvider(),
        DisposableProvider(create: (context) => Authenticator()),
        Provider(create: (context) => UserObserver()),
        ChangeNotifierProvider<AccountNotifier>(
          create: (context) => AccountNotifier(
            authenticator: Provider.of(context, listen: false),
            userObserver: Provider.of(context, listen: false),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
