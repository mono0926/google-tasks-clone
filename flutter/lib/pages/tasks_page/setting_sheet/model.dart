import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/service/service.dart';

class Model extends ChangeNotifier {
  Model({@required this.authenticator});
  final Authenticator authenticator;

  var _status = Status.signedIn;

  Status get status => _status;

  void signOut() async {
    _updateStatus(Status.inProgress);
    await authenticator.signOut();
    _updateStatus(Status.signedOut);
  }

  void _updateStatus(Status status) {
    _status = status;
    notifyListeners();
  }
}

enum Status {
  signedIn,
  inProgress,
  signedOut,
}
