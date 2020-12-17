
import 'package:flutter/material.dart';

import 'main.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Examples'),
          ),
          ListTile(
            title: Text('Basic usage'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) => BasicScreen()));
            },
          ),
          ListTile(
            title: Text('With overrides'),
            leading: Icon(Icons.home_repair_service),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) => Screen()));
            },
          ),
          ListTile(
            title: Text('With Error'),
            leading: Icon(Icons.error_outline, color: Colors.red),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) => ErrorScreen()));
            },
          ),
        ],
      ),
    );
  }
}