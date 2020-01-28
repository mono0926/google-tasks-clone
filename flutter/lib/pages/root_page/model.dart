import 'package:flutter/cupertino.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/pages/tasks_page/tasks_page.dart';
import 'package:google_tasks/pages/welcome_page/welcome_page.dart';
import 'package:google_tasks/util/util.dart';
import 'package:mono_kit/mono_kit.dart';

class Model with SubscriptionHolderMixin {
  Model({
    @required this.authenticator,
    @required this.navigator,
  }) {
    _navigateToRootPage();
  }

  final Authenticator authenticator;
  final AppNavigator navigator;

  Future _navigateToRootPage() async {
    subscriptionHolder.add(
      authenticator.firUser
          .map((firUser) {
            return firUser == null
                ? WelcomePage.routeName
                : TasksPage.routeName;
          })
          .distinct((a, b) => a == b)
          .listen(
            (routeName) => navigator.navigator.pushReplacementNamed(routeName),
          ),
    );
  }
}
