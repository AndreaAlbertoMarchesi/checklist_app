
import 'package:checklist_app/model/AppState.dart';
import 'package:checklist_app/view/Settings/SettingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:<Widget> [
          DrawerHeader(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircleAvatar(
                    ),
                  ),
                  Text("nome.cognome")
                ],
              )
          ),
          ListTile(
            title: Text("Home"),
            onTap: (){
              appState.backToRoot();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          ListTile(
            title: Text('Help'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
