import 'package:intl/intl.dart';

mixin Messages {
  String get welcomeTitle => Intl.message(
        'Welcome to Tasks',
        name: 'welcomeTitle',
      );
}
