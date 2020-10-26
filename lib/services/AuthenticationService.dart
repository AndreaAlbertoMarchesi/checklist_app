import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist_app/model/AppUser.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User currentUser;
  GoogleSignInAccount googleUser;
  static const PHOTO_ANON = "https://icon-library.com/images/profile-42914__340.png";

  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(String photoURL) {
    if(googleUser != null){
      return AppUser(uid: googleUser.id, email: googleUser.email, photoURL: photoURL);
    }else{
      return currentUser.isAnonymous ? AppUser(uid: currentUser.uid, email: "Anonymous User", photoURL: photoURL, isAnon: true)
                                        : AppUser(uid: currentUser.uid, email: currentUser.email, photoURL: photoURL, isAnon: false);
    }

  }

  //this method for later
  void _verifyEmail() async {
    if (!currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
    }
    // Get the code from the email:
    String code = 'xxxxxxx';

    try {
      await _firebaseAuth.checkActionCode(code);
      await _firebaseAuth.applyActionCode(code);

      // If successful, reload the user:
      _firebaseAuth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        print('The code is invalid.');
      }
    }
  }


  Future<AppUser> signInAnonymously()async{
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      currentUser = userCredential.user;
      return _userFromFirebaseUser(PHOTO_ANON);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // sign in with email and password
  Future<AppUser> signInWithEmailAndPassword(String email, String password, String photoUrl) async {
    try {

      deleteUser();
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      //if(userCredential.user.emailVerified) {
        currentUser = userCredential.user;
        return _userFromFirebaseUser(photoUrl);
      //}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<AppUser> registerWithEmailAndPassword(String email, String password) async {

    try {

      final credential = EmailAuthProvider.credential(email: email, password: password);
      await currentUser.linkWithCredential(credential);
      currentUser = _firebaseAuth.currentUser;

      _verifyEmail();

      return _userFromFirebaseUser(PHOTO_ANON);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // sign out
  Future<AppUser> signOut() async {
    if(googleUser != null){
      signOutGoogle();
    }else {
      try {
        await _firebaseAuth.signOut();
        return signInAnonymously();
      } catch (error) {
        print(error.toString());
        return null;
      }
    }
    return null;
  }

  Future<AppUser> signInWithGoogle() async{

    googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return _userFromFirebaseUser(user.photoURL);
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    googleUser = null;
    print("User Signed Out");
  }

  //delete a user
  void deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must re-authenticate before this operation can be executed.');
      }
    }
  }

  void reAuthenticate(String email, String password) async {
    // Create a credential
    EmailAuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);

    await FirebaseAuth.instance.currentUser
        .reauthenticateWithCredential(credential);
  }
}
