import 'package:intl/intl.dart';

mixin Messages {
  String get buttonDone => Intl.message(
        'DONE',
        name: 'done',
      );
  String get welcomeTitle => Intl.message(
        'Welcome to Tasks',
        name: 'welcomeTitle',
      );
}
