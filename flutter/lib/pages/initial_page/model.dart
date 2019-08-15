import 'package:flutter/cupertino.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';

class Model extends ChangeNotifier {
  Model({@required this.authenticator}) {
    decideNextRoute();
  }

  void decideNextRoute() async {
    final firUser = await authenticator.firUser();
    _nextRouteName =
        firUser == null ? WelcomePage.routeName : TasksPage.routeName;
    notifyListeners();
  }

  final Authenticator authenticator;
  String _nextRouteName;
  String get nextRouteName => _nextRouteName;
}
