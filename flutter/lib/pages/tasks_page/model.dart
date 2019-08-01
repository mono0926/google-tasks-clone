import 'package:flutter/foundation.dart';

class Model extends ChangeNotifier {
  bool _isInputSheetShown = false;
  bool _isDescriptionShown = false;
  bool get isInputSheetShown => _isInputSheetShown;
  bool get isDescriptionShown => _isDescriptionShown;

  void toggleInputSheet({@required bool shown}) {
    _isInputSheetShown = shown;
    if (!shown) {
      _isDescriptionShown = false;
    }
    notifyListeners();
  }

  void showDescription() {
    _isDescriptionShown = true;
    notifyListeners();
  }
}
