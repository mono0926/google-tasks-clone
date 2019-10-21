import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/service/authenticator/authenticator.dart';
import 'package:google_tasks/model/service/user_observer.dart';
import 'package:meta/meta.dart';
import 'package:mono_kit/mono_kit.dart';

class AccountNotifier extends ChangeNotifier with SubscriptionHolderMixin {
  AccountNotifier({
    @required this.authenticator,
    @required this.userObserver,
  }) {
    subscriptionHolder.add(
      _auth.onAuthStateChanged.listen((firUser) {
        final uid = firUser?.uid;
        final uidChanged = _firUser?.uid != uid;
        _firUser = firUser;
        if (uidChanged) {
          if (firUser == null) {
            _userDoc = null;
          } else {
            _userObserveSubscription?.cancel();
            _userObserveSubscription = userObserver.doc(uid).listen((userDoc) {
              _userDoc = userDoc;
              notifyListeners();
              if (userDoc == null) {
                UsersRef.ref().docRef(uid).setData(<String, dynamic>{});
              }
            });
          }
        }
      }),
    );
  }

  final Authenticator authenticator;
  final UserObserver userObserver;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _firUser;
  UserDoc _userDoc;
  StreamSubscription _userObserveSubscription;

  UserDoc get userDoc => _userDoc;
  FirebaseUser get firUser => _firUser;

  @override
  void dispose() {
    _userObserveSubscription?.cancel();

    super.dispose();
  }
}
