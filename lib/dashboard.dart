import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _energiaAtual = 5; 
  int _consumoAtual = 4; 
  int _nivelBateria = 80; 

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startUpdatingValues();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startUpdatingValues() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _energiaAtual = _generateRandomValue(3, 10);
        _consumoAtual = _generateRandomValue(2, 9);
        _nivelBateria = _generateRandomValue(50, 100);
      });
    });
  }

  int _generateRandomValue(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  void _openConfigDialog() {
    TextEditingController energiaController = TextEditingController(text: _energiaAtual.toString());
    TextEditingController consumoController = TextEditingController(text: _consumoAtual.toString());
    TextEditingController bateriaController = TextEditingController(text: _nivelBateria.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Configurar Valores'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: energiaController,
                decoration: InputDecoration(labelText: 'Produção de Energia Atual (kW)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: consumoController,
                decoration: InputDecoration(labelText: 'Consumo Atual (kW)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bateriaController,
                decoration: InputDecoration(labelText: 'Nível da Bateria (%)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _energiaAtual = int.tryParse(energiaController.text) ?? _energiaAtual;
                  _consumoAtual = int.tryParse(consumoController.text) ?? _consumoAtual;
                  _nivelBateria = int.tryParse(bateriaController.text) ?? _nivelBateria;
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel de Controle"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openConfigDialog,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Produção de Energia Atual: $_energiaAtual kW",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Consumo Atual: $_consumoAtual kW",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Nível da Bateria: $_nivelBateria%",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
