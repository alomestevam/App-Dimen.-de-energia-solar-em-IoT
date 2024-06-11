import 'package:flutter/material.dart';

class Suporte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suporte e Comunidade"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Perguntas Frequentes"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Tutoriais"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Comunidade"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
