import 'package:flutter/foundation.dart';

class Model extends ChangeNotifier {
  var _isInputSheetShown = false;
  var _isDetailsShown = false;
  bool get isInputSheetShown => _isInputSheetShown;
  bool get isDetailsShown => _isDetailsShown;

  void toggleInputSheet({@required bool shown}) {
    _isInputSheetShown = shown;
    if (!shown) {
      _isDetailsShown = false;
    }
    notifyListeners();
  }

  void showDetails() {
    _isDetailsShown = true;
    notifyListeners();
  }
}
