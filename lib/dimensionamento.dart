import 'package:flutter/material.dart';

class Dimensionamento extends StatefulWidget {
  @override
  _DimensionamentoState createState() => _DimensionamentoState();
}

class _DimensionamentoState extends State<Dimensionamento> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController roofSizeController = TextEditingController();
  final TextEditingController orientationController = TextEditingController();
  final TextEditingController tiltController = TextEditingController();
  final TextEditingController consumptionController = TextEditingController();

  String _result = '';

  void _calculateDimensionamento() {
    // Lógica simples para calcular o dimensionamento
    final double roofSize = double.tryParse(roofSizeController.text) ?? 0;
    final double consumption = double.tryParse(consumptionController.text) ?? 0;

    if (roofSize > 0 && consumption > 0) {
      // Exemplo de cálculo: quantidade de painéis necessária
      final double panelsNeeded = consumption / roofSize;
      setState(() {
        _result = 'Você precisa de aproximadamente ${panelsNeeded.toStringAsFixed(2)} painéis solares.';
      });
    } else {
      setState(() {
        _result = 'Por favor, insira valores válidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dimensionamento do Sistema Solar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de voltar personalizado
          onPressed: () {
            Navigator.pop(context); // Função para voltar para a tela anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "Localização",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: roofSizeController,
              decoration: InputDecoration(
                labelText: "Tamanho do Telhado (m²)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: orientationController,
              decoration: InputDecoration(
                labelText: "Orientação",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: tiltController,
              decoration: InputDecoration(
                labelText: "Inclinação (°)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: consumptionController,
              decoration: InputDecoration(
                labelText: "Consumo de Energia (kWh)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateDimensionamento,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text("Calcular"),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
