
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ciao");
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
            onTap: (){},
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
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
