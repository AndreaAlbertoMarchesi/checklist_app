import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/model/AppUser.dart';
import 'package:checklist_app/services/AuthenticationService.dart';
import 'package:checklist_app/view/authentication/LoadingPage.dart';
import 'package:checklist_app/view/Settings/DarkThemeState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
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
        elevation: 0.0,
        title: Text('Login in page'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
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
                  fillColor:getColor(),
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
                obscureText: true,
                validator: (val) =>
                val.length < 6
                    ? 'Enter a password 6+ chars long'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      await appState.registerWithEmailAndPsw(
                          email, password);
                      if (appState.appUser.email == "Anonymous") {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
