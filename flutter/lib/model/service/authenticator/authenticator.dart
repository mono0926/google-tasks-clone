import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_tasks/util/util.dart';

export 'auth_error_codes.dart';

class Authenticator {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  Future<FirebaseUser> firUser() => _auth.currentUser();
  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  Future<FirebaseUser> signIn() async {
    final current = await _auth.currentUser();
    if (current != null) {
      logger.shout(
          'signIn should be called only if signed out(current: $current).');
      return current;
    }
    final gAccount = await _googleSignIn.signIn();
    if (gAccount == null) {
      return null;
    }
    final gAuth = await gAccount.authentication;
    final authResult = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      ),
    );
    logger.info(authResult);
    return authResult?.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
//    await _googleSignIn.signOut();
  }
}
