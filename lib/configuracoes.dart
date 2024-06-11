import 'package:flutter/material.dart';

class Configuracoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwitchListTile(
              title: Text("Alertas de Baixa Produção"),
              value: true,
              onChanged: (bool value) {},
            ),
            SwitchListTile(
              title: Text("Modo de Economia de Energia"),
              value: false,
              onChanged: (bool value) {},
            ),
            ListTile(
              title: Text("Atualizações de Firmware"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
