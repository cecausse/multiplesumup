import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com']);

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        return _googleSignIn.currentUser;
      }
      return await _googleSignIn.signIn();
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> signOut() async {
    _googleSignIn.signOut();
  }
}
