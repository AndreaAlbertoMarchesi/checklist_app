import 'package:checklist_app/model/AppState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {


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
                backgroundImage: NetworkImage("${appState.appUser.photoURL}"),
                backgroundColor: Colors.transparent,
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
                    appState.signOut();
                      setState(() {
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
