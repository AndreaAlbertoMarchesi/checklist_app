import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/AppUser.dart';
import 'package:checklist_app/services/AuthenticationService.dart';
import 'package:checklist_app/view/Settings/DarkThemeState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'LoadingPage.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    final darkState = context.watch<DarkThemeState>();
    final appState = context.watch<AppState>();

    Color getColor(){
      if(darkState.darkTheme){
        return Colors.blueGrey;
      }else{
        return Colors.lightBlue;
      }
    }

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.lightBlue[200],
      appBar: AppBar(
        backgroundColor: getColor(),
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "email",
                  fillColor: getColor(),
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: getColor(), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent[700], width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  fillColor: getColor(),
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: getColor(), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent[700], width: 2.0),
                  ),
                ),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      await appState.signInWithEmailAndPassword(email, password);
                      if(appState.appUser.email == "Anonymous") {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
                      }else{
                        setState(() {
                          loading =false;
                          Navigator.of(context).pop();
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              OutlineButton(
                splashColor: Colors.blueGrey[300],
                onPressed: () async{
                  await appState.signInWithGoogle();
                  if(appState.appUser.email == "Anonymous"){
                    setState(() {
                      print("error");
                      loading = false;
                      error = 'Could not sign in with those credentials';
                      Navigator.of(context).pop();
                    });
                  }else{
                    loading =false;
                    Navigator.of(context).pop();
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.blueAccent[700]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
