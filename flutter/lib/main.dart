import 'package:flutter/material.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/model.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          // TODO(mono): ライブラリを直して警告解消
          RouteObserverProvider(),
          Provider.value(value: TasksHolder()),
        ],
        child: const App(),
      ),
    );
