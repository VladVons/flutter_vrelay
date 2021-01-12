import 'package:flutter/material.dart';
import '../util/lang.dart';


class PageConnection extends StatelessWidget {
  bool valuefirst = false;  
  final controlName = TextEditingController();
  final controlHost = TextEditingController();
  final controlPort = TextEditingController();
  final controlUser = TextEditingController();
  final controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Divider(
            height: 20.0,
          ),
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(
                labelText: TLang.getKey(context, 'Name'),
              ),
              controller: controlName,
            )
          ),
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(
                //icon: Icon(Icons.http),
                labelText: TLang.getKey(context, 'Host'),
              ),
              controller: controlHost,
              keyboardType: TextInputType.url,
            )
          ),
          ListTile(
            title: TextFormField(
            decoration: InputDecoration(
                labelText: TLang.getKey(context, 'Port'),
                hintText: '1883'
              ),
              controller: controlPort,
              keyboardType: TextInputType.number,
            )
          ),
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(
                labelText: TLang.getKey(context, 'User'),
              ),
              controller: controlUser,
            )
          ),
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(
                labelText: TLang.getKey(context, 'Password'),
              ),
              controller: controlPassword,
              obscureText: true
            )
          ),
          CheckboxListTile(
            value: valuefirst,
            title: Text('Active'), 
            onChanged: (bool value) { 
              valuefirst = value;
            },
          ),
          Divider(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    //Navigator.push(context, 
                    //  new MaterialPageRoute(builder: (context) => new SecondScreen()),
                    //);
                  },
                  child: Text('Sample Push!'),
                )
            ],
          )
        ]
      )
    );
  }
}
