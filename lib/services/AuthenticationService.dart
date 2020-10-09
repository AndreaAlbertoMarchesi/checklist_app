import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }










}
