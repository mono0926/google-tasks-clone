import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/service/service.dart';

class Model extends ChangeNotifier {
  Model({
    @required this.authenticator,
  });
  final Authenticator authenticator;
  var _status = Status.loggedOut;

  Status get status => _status;

  Future signIn() async {
    _updateStatus(Status.inProgress);
    final firUser = await authenticator.signIn();
    _updateStatus(firUser == null ? Status.loggedOut : Status.loggedIn);
  }

  void _updateStatus(Status status) {
    _status = status;
    notifyListeners();
  }
}

enum Status {
  loggedOut,
  inProgress,
  loggedIn,
}
