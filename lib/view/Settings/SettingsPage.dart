
import 'package:checklist_app/view/authentication/Authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _dark= false;
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
            child: Text("nome.cognome@mail.com"),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.lightbulb_outline),
            value: _dark,
            title: Text("Dark mode"),
            onChanged: (value) {
              setState(() {
                _dark = value;

              });
              //dark mode implementation
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined),
            value: _notification,
            title: Text("Notification"),
            onChanged: (value) {
              setState(() {
                _notification = value;
              });
            },
          ),
          ListTile(
            title: Center(child: Text("Account")),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Authenticate()));
            },
          ),
          ListTile(
            title: Center(child: Text("Terms & Conditions")),
            subtitle: Center(child: Text("Click to know more about terms and conditions")),
            onTap: (){

            },
          ),
          Center(child: Text("version 1.0.0"))
        ],
      ),
    );
  }
}
