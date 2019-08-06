import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'app.dart';
import 'model/model.dart';

void main() {
  final originalFlutterError = FlutterError.onError;
  FlutterError.onError = (error) {
    originalFlutterError(error);
    Crashlytics.instance.recordFlutterError(error);
  };
  runApp(
    MultiProvider(
      providers: [
        // TODO(mono): ライブラリを直して警告解消
        RouteObserverProvider(),
        Provider.value(value: TasksHolder()),
      ],
      child: const App(),
    ),
  );
}
