import 'package:flutter/material.dart';
import '../util/lang.dart';
import '../screen/connection.dart';


class PageHome extends StatelessWidget {
  @override
  Widget build(BuildContext aContext) {
    return Scaffold(
      appBar: AppBar(title: Text(TLang.getKey(aContext, 'Main'))),
      body: Center(child: Text('My Page!')),
      drawer: extDrawer(aContext),
    );
  }

  Drawer extDrawer(BuildContext aContext) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(TLang.getKey(aContext, 'Connection')),
            onTap: () {
              Navigator.push(aContext, 
                MaterialPageRoute(
                  builder: (aContext) => PageConnection())
              );              
            },
          ),
          ListTile(
            title: Text('Exit'),
            onTap: () {
              //SystemNavigator.pop();
              Navigator.pop(aContext);
            },
          ),
        ],
      ),
    );
  }
}
