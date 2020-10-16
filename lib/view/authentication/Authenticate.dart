import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/view/authentication/Register.dart';
import 'package:checklist_app/view/authentication/SignOut.dart';
import 'package:checklist_app/view/authentication/Sign_In.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

    final appState = context.watch<AppState>();

    if(appState.appUser.uid == "Anonymous") {
      if (showSignIn) {
        return SignIn(toggleView: toggleView);
      } else {
        return Register(toggleView: toggleView);
      }
    }else{
      return SignOut();
    }
  }
}
