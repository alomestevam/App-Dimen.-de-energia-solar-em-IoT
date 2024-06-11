import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Monitoramento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoramento em Tempo Real"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de voltar personalizado
          onPressed: () {            Navigator.pop(context); // Função para voltar para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true),
              bottomTitles: SideTitles(showTitles: true),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 0),
                  FlSpot(1, 2),
                  FlSpot(2, 1.5),
                  FlSpot(3, 3),
                  FlSpot(4, 2.5),
                  FlSpot(5, 4),
                ],
                isCurved: true,
                colors: [Colors.blue],
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              ),
            ],
            minX: 0,
            maxX: 5,
            minY: 0,
            maxY: 5,
          ),
        ),
      ),
    );
  }
}

           
