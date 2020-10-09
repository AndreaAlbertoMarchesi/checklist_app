import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist_app/model/AppUser.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid, email: user.email) : null;
  }

  void _verifyEmail(User user) async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
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

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      ///_verifyEmail(user);

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
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
