// https://medium.com/flutter-community/a-guide-to-using-futures-in-flutter-for-beginners-ebeddfbfb967

import 'package:flutter/material.dart';
import '../util/lang.dart';
import '../util/mqtt.dart';

class PageConnection extends StatelessWidget {
  bool valuefirst = !false;
  final controlName = TextEditingController();
  final controlHost = TextEditingController(text: 'Test1');
  final controlPort = TextEditingController();
  final controlUser = TextEditingController();
  final controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //@override
    // void dispose() {
    //   controlName.dispose();
    //   super.dispose();
    // }

    controlName.text = 'Test3';

    return Scaffold(
        body: Column(
      children: <Widget>[
        const SizedBox(height: 32),
        //buildActive(context),
        CheckboxListTile(
          value: valuefirst,
          title: Text(TLang.getKey(context, 'Active')),
          onChanged: (bool value) {},
          //onChanged: (bool value) {
          //setState(() {
          //    valuefirst = value;
          // });
          //  }
        ),
        buildName(context),
        buildHost(context),
        buildPort(context),
        buildUser(context),
        buildPassword(context),
        const SizedBox(height: 32),
        RaisedButton(
          onPressed: () async {
            //Navigator.push(context,
            //  new MaterialPageRoute(builder: (context) => new SecondScreen()),
            //);
            //controlName.text = 'Test3----';
            TMqtt Mqtt = TMqtt();
            if (await Mqtt.Init(controlHost.text) == false) {

            }

            if (Mqtt.Test()) {}
          },
          child: Text('Sample Push!'),
        )
      ],
    ));
  }

  Widget buildActive(BuildContext context) => CheckboxListTile(
        value: valuefirst,
        title: Text(TLang.getKey(context, 'Active')),
        onChanged: (bool value) {
          //setState(() {
          //  valuefirst = value;
          // });
        },
      );

  Widget buildName(BuildContext context) => ListTile(
      title: TextFormField(
          key: Key('Name1'),
          decoration: InputDecoration(
            labelText: TLang.getKey(context, 'Name'),
          ),
          controller: controlName));

  Widget buildHost(BuildContext context) => ListTile(
          title: TextFormField(
        decoration: InputDecoration(
          //icon: Icon(Icons.http),
          labelText: TLang.getKey(context, 'Host'),
        ),
        controller: controlHost,
        keyboardType: TextInputType.url,
      ));

  Widget buildPort(BuildContext context) => ListTile(
          title: TextFormField(
        decoration: InputDecoration(
            labelText: TLang.getKey(context, 'Port'), hintText: '1883'),
        controller: controlPort,
        keyboardType: TextInputType.number,
      ));

  Widget buildUser(BuildContext context) => ListTile(
          title: TextFormField(
        decoration: InputDecoration(
          labelText: TLang.getKey(context, 'User'),
        ),
        controller: controlUser,
      ));

  Widget buildPassword(BuildContext context) => ListTile(
      title: TextFormField(
          decoration: InputDecoration(
            labelText: TLang.getKey(context, 'Password'),
          ),
          controller: controlPassword,
          obscureText: true));
}
