import 'package:flutter/widgets.dart';
import 'package:google_tasks/l10n/l10n.dart';
import 'package:mono_kit/mono_kit.dart';

import 'util.dart';

mixin StateHelperMixin<T extends StatefulWidget> on State<T> {
  @protected
  final SubscriptionHolder subscriptionHolder = SubscriptionHolder();
  @protected
  bool get isCurrentRoute => mounted && ModalRoute.of(context).isCurrent;
  @protected
  AppFeedback get feedback => AppFeedback.fromContext(context);
  @protected
  L10n get l10n => L10n.of(context);

  void registerFeedback(Stream<String> stream) {
    subscriptionHolder.add(
      stream.listen(
        (message) {
          if (!isCurrentRoute) {
            return;
          }
          feedback.show(message);
        },
        onError: (dynamic error) {
          if (!isCurrentRoute) {
            return;
          }
          feedback.showError(error);
        },
      ),
    );
  }

  @override
  void dispose() {
    subscriptionHolder.dispose();
    super.dispose();
  }
}
