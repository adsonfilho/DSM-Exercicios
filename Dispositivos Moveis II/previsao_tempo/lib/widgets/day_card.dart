import 'package:flutter/material.dart';

import '../models/forecast.dart';
import '../utils/date_utils.dart';
import '../utils/weather_condition.dart';

class DayCard extends StatelessWidget {
  final DayForecast day;

  const DayCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final condition = WeatherCondition.fromCode(day.conditionCode);
    final theme = Theme.of(context);
    final min = day.minTemp != null ? '${day.minTemp}°C' : '—';
    final max = day.maxTemp != null ? '${day.maxTemp}°C' : '—';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(condition.icon, size: 44, color: condition.color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day.date == null
                        ? 'Data não informada'
                        : '${weekdayName(day.date)} • ${formatDate(day.date)}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(condition.description, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.arrow_downward,
                            size: 16, color: Colors.blue),
                        label: Text('Mín $min'),
                        visualDensity: VisualDensity.compact,
                      ),
                      Chip(
                        avatar: const Icon(Icons.arrow_upward,
                            size: 16, color: Colors.deepOrange),
                        label: Text('Máx $max'),
                        visualDensity: VisualDensity.compact,
                      ),
                      if (day.uvIndex != null)
                        Chip(
                          avatar: const Icon(Icons.wb_sunny_outlined,
                              size: 16, color: Colors.amber),
                          label: Text('IUV ${day.uvIndex!.toStringAsFixed(1)}'),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
