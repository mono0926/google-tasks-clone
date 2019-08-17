import 'package:flutter/cupertino.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:rxdart/rxdart.dart';

class Model with SubscriptionHolderMixin {
  Model({
    @required this.authenticator,
    @required this.navigatorKey,
  }) {
    _decideNextRouteName();
  }

  final Authenticator authenticator;
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorState get _navigator => navigatorKey.currentState;

  void _decideNextRouteName() async {
    subscriptionHolder.add(
      Observable(authenticator.onAuthStateChanged)
          .map<String>((firUser) {
            return firUser == null
                ? WelcomePage.routeName
                : TasksPage.routeName;
          })
          .distinct((a, b) => a == b)
          .listen(_updateNextRouteName),
    );
  }

  void _updateNextRouteName(String routeName) {
    logger.info(routeName);
    if (routeName != null) {
      _navigator
        ..popUntil((r) => r.isFirst)
        ..pushNamed(routeName);
    }
  }
}
