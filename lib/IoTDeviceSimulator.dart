import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// Classe que simula os dados do sensor IoT
class IoTDeviceSimulator {
  final int _minValue;
  final int _maxValue;
  final Duration _updateInterval;
  late StreamController<int> _sensorDataStreamController;
  late Timer _updateTimer;

  // Construtor da classe
  IoTDeviceSimulator({
    int minValue = 0,
    int maxValue = 100,
    Duration updateInterval = const Duration(seconds: 1),
  })  : _minValue = minValue,
        _maxValue = maxValue,
        _updateInterval = updateInterval {
    _sensorDataStreamController = StreamController<int>();
    _updateTimer = Timer.periodic(_updateInterval, _updateSensorData);
  }

  // Método para obter o fluxo de dados do sensor
  Stream<int> get sensorDataStream => _sensorDataStreamController.stream;

  // Método privado para atualizar os dados do sensor em intervalos regulares
  void _updateSensorData(Timer timer) {
    final randomValue = _minValue + Random().nextInt(_maxValue - _minValue + 1);
    _sensorDataStreamController.add(randomValue);
  }

  // Método para encerrar a simulação do sensor
  void dispose() {
    _updateTimer.cancel();
    _sensorDataStreamController.close();
  }
}

class IntegracaoIoT extends StatefulWidget {
  @override
  _IntegracaoIoTState createState() => _IntegracaoIoTState();
}

class _IntegracaoIoTState extends State<IntegracaoIoT> {
  late IoTDeviceSimulator _iotSimulator; // Instância do simulador

  @override
  void initState() {
    super.initState();
    _iotSimulator = IoTDeviceSimulator(); // Inicia o simulador
  }

  @override
  void dispose() {
    _iotSimulator.dispose(); // Encerra o simulador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Integração IoT")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              stream: _iotSimulator.sensorDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "Dados do Sensor: ${snapshot.data}",
                    style: TextStyle(fontSize: 24),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para conectar ao dispositivo IoT (se necessário)
              },
              child: Text("Conectar ao Medidor Inteligente"),
            ),
          ],
        ),
      ),
    );
  }
}
