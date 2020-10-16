import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/AppUser.dart';
import 'package:checklist_app/services/AuthenticationService.dart';
import 'package:checklist_app/view/Settings/DarkThemeState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {

    final appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 50,
                //background image
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(appState.appUser.email),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0,8.0, 8.0,8.0),
                child: Icon(Icons.account_circle_outlined),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,8.0, 8.0,8.0),
                child: RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: () async{
                    dynamic result = await _auth.signOut();
                      setState(() {
                        appState.signOut();
                        Navigator.of(context).pop();
                      });
                  },

                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
