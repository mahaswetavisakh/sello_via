import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AlertDialog(),
  ));
}

class AlertDialog extends StatefulWidget {
  @override
  State<AlertDialog> createState() => _AlertDialogState();
}

class _AlertDialogState extends State<AlertDialog> {
  String? language;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text("Mahasweta"), accountEmail: Text("mahasweta@gmail.com"))
          ],
        ),
      ),
      body: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.blue, fontSize: 42),
              children: <TextSpan>[
                TextSpan(
                    text: 'My flutter', style: TextStyle(color: Colors.orange)),
                TextSpan(
                    text: 'App',
                    style: TextStyle(decoration: TextDecoration.underline))
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Text("Select your programming language",
            textAlign: TextAlign.left,style: TextStyle(fontSize: 20),),

          ListTile(
            title: Text("Dart"),
            leading: Radio(
                value: 'dart', groupValue: language, onChanged: (String? value) {
              setState(() {
                language=value;
              });
            }),
          ),
          ListTile(
            title: Text("C"),
            leading: Radio(
                value: 'C', groupValue: language, onChanged: (String? value) {
              setState(() {
                language=value;
              });
            }),
          ),
          ListTile(
            title: Text("Kotlin"),
            leading: Radio(
                value: 'kotlin', groupValue: language, onChanged: (String? value) {
              setState(() {
                language=value;
              });
            }),
          ),
        ],
      ),
    );
  }
}