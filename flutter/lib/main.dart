import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_tasks/model/notifier/account.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/model/service/user_observer.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'app.dart';
import 'model/notifier/notifier.dart';

void main() {
  final originalFlutterError = FlutterError.onError;
  FlutterError.onError = (error) {
    originalFlutterError(error);
    Crashlytics.instance.recordFlutterError(error);
  };
  runApp(
    MultiProvider(
      providers: [
        RouteObserverProvider(),
        Provider.value(value: Authenticator()),
        StreamProvider<FirebaseUser>(
          builder: (context) =>
              Provider.of<Authenticator>(context, listen: false)
                  .onAuthStateChanged
                  .distinct((a, b) => a?.uid == b?.uid),
        ),
        Provider.value(value: UserObserver()),
        ChangeNotifierProxyProvider2<Authenticator, UserObserver, Account>(
          builder: (context, authenticator, userObserver, previous) =>
              previous ??
              Account(
                authenticator: authenticator,
                userObserver: userObserver,
              ),
        ),
      ],
      child: const App(),
    ),
  );
}
