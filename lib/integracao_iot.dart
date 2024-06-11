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
  int _sensorData = 0; // Armazena os dados do sensor
  late IoTDeviceSimulator _simulator; // Instância do simulador

  @override
  void initState() {
    super.initState();
    _startSensorSimulation(); // Inicia a simulação do sensor
  }

  @override
  void dispose() {
    _stopSensorSimulation(); // Encerra a simulação do sensor
    super.dispose();
  }

  void _startSensorSimulation() {
    // Inicia a simulação do sensor
    _simulator = IoTDeviceSimulator(); // Inicializa o simulador
    _simulator.sensorDataStream.listen((sensorData) {
      setState(() {
        _sensorData = sensorData; // Atualiza os dados do sensor no estado
      });
    });
  }

  void _stopSensorSimulation() {
    // Encerra a simulação do sensor
    _simulator.dispose(); // Encerra a simulação
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integração IoT"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de voltar personalizado
          onPressed: () {
            Navigator.pop(context); // Função para voltar para a tela anterior
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Dados do Sensor: $_sensorData", // Exibe os dados do sensor
              style: TextStyle(fontSize: 24),
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
