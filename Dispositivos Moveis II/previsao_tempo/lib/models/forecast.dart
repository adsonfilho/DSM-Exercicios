import 'city.dart';

/// Previsão de um único dia. Todos os campos são opcionais, pois o serviço
/// pode omitir informações.
class DayForecast {
  final DateTime? date;
  final int? minTemp;
  final int? maxTemp;
  final String? conditionCode;
  final double? uvIndex;

  const DayForecast({
    this.date,
    this.minTemp,
    this.maxTemp,
    this.conditionCode,
    this.uvIndex,
  });

  Map<String, dynamic> toJson() => {
        'date': date?.toIso8601String(),
        'minTemp': minTemp,
        'maxTemp': maxTemp,
        'conditionCode': conditionCode,
        'uvIndex': uvIndex,
      };

  factory DayForecast.fromJson(Map<String, dynamic> json) => DayForecast(
        date: json['date'] == null
            ? null
            : DateTime.tryParse(json['date'] as String),
        minTemp: (json['minTemp'] as num?)?.toInt(),
        maxTemp: (json['maxTemp'] as num?)?.toInt(),
        conditionCode: json['conditionCode'] as String?,
        uvIndex: (json['uvIndex'] as num?)?.toDouble(),
      );
}

/// Previsão de quatro dias de uma cidade.
class Forecast {
  final City city;

  /// Data de atualização informada pelo serviço.
  final DateTime? updatedAt;
  final List<DayForecast> days;

  /// Momento em que o app obteve/salvou estes dados.
  final DateTime fetchedAt;

  const Forecast({
    required this.city,
    required this.updatedAt,
    required this.days,
    required this.fetchedAt,
  });

  Map<String, dynamic> toJson() => {
        'city': city.toJson(),
        'updatedAt': updatedAt?.toIso8601String(),
        'days': days.map((d) => d.toJson()).toList(),
        'fetchedAt': fetchedAt.toIso8601String(),
      };

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        city: City.fromJson(json['city'] as Map<String, dynamic>),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.tryParse(json['updatedAt'] as String),
        days: (json['days'] as List<dynamic>)
            .map((e) => DayForecast.fromJson(e as Map<String, dynamic>))
            .toList(),
        fetchedAt: DateTime.tryParse(json['fetchedAt'] as String? ?? '') ??
            DateTime.now(),
      );
}
