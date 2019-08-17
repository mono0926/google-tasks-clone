import 'package:flutter/material.dart';
import 'package:google_tasks/exception/app_exception.dart';
import 'package:google_tasks/l10n/l10n.dart';

import 'util.dart';

class AppFeedback {
  AppFeedback(this.key);
  AppFeedback.fromState(ScaffoldState state) : _state = state;
  AppFeedback.fromContext(BuildContext context)
      : this.fromState(Scaffold.of(context));

  GlobalKey<ScaffoldState> key;
  ScaffoldState _state;

  ScaffoldState get state => _state ?? key.currentState;
  BuildContext get context => state.context;

  void show(String text) {
    state
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text)),
      );
  }

  void showUndo({
    @required String text,
    @required VoidCallback onUndo,
  }) {
    final l10n = L10n.of(context);
    state
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          action: SnackBarAction(
            textColor: Theme.of(context).textSelectionColor,
            label: l10n.buttonUndo,
            onPressed: onUndo,
          ),
        ),
      );
  }

  void notImplemented() {
    showError(AppException.notImplemented);
  }

  void showError(dynamic error) {
    state
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            localizeError(
              error: error,
              l10n: L10n.of(context),
            ),
          ),
        ),
      );
  }
}
