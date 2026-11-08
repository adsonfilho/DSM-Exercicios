import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/forecast.dart';
import '../utils/date_utils.dart';
import '../widgets/message_view.dart';
import '../widgets/source_footer.dart';

/// Tela 3: gráfico de linhas com temperaturas mínima e máxima.
class ChartScreen extends StatelessWidget {
  final Forecast forecast;

  const ChartScreen({super.key, required this.forecast});

  static const _maxColor = Colors.deepOrange;
  static const _minColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperaturas • ${forecast.city.label}')),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final days = forecast.days;
    final maxSpots = <FlSpot>[];
    final minSpots = <FlSpot>[];

    for (var i = 0; i < days.length; i++) {
      final d = days[i];
      if (d.maxTemp != null) maxSpots.add(FlSpot(i.toDouble(), d.maxTemp!.toDouble()));
      if (d.minTemp != null) minSpots.add(FlSpot(i.toDouble(), d.minTemp!.toDouble()));
    }

    if (maxSpots.isEmpty && minSpots.isEmpty) {
      return const MessageView(
        icon: Icons.show_chart,
        message: 'Não há dados de temperatura disponíveis para gerar o gráfico.',
      );
    }

    final allValues = [...maxSpots, ...minSpots].map((s) => s.y);
    final minY = (allValues.reduce(math.min) - 3).floorToDouble();
    final maxY = (allValues.reduce(math.max) + 3).ceilToDouble();
    final interval = math.max(1.0, ((maxY - minY) / 5).ceilToDouble());
    final maxX = math.max(1, days.length - 1).toDouble();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Previsão de temperatura (°C)',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const Row(
            children: [
              _Legend(color: _maxColor, label: 'Máxima'),
              SizedBox(width: 16),
              _Legend(color: _minColor, label: 'Mínima'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: maxX,
                  minY: minY,
                  maxY: maxY,
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black12),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: interval,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}°',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (value != i.toDouble() ||
                              i < 0 ||
                              i >= days.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(formatShortDate(days[i].date),
                                style: const TextStyle(fontSize: 12)),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    _line(maxSpots, _maxColor),
                    _line(minSpots, _minColor),
                  ],
                ),
              ),
            ),
          ),
          const SourceFooter(),
        ],
      ),
    );
  }

  LineChartBarData _line(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: true, color: color.withAlpha(25)),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
