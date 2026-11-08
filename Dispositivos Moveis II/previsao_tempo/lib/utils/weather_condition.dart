import 'package:flutter/material.dart';

/// Converte as siglas de condição do tempo do CPTEC/INPE em descrição e ícone.
/// Tabela conforme a documentação do serviço (http://servicos.cptec.inpe.br/XML/).
class WeatherCondition {
  final String description;
  final IconData icon;
  final Color color;

  const WeatherCondition(this.description, this.icon, this.color);

  static WeatherCondition fromCode(String? code) {
    if (code == null || code.trim().isEmpty) {
      return const WeatherCondition(
          'Condição não informada', Icons.help_outline, Colors.grey);
    }
    final c = code.trim().toLowerCase();
    return _table[c] ??
        WeatherCondition(
            'Condição desconhecida ($c)', Icons.help_outline, Colors.grey);
  }

  static const _sun = Icons.wb_sunny;
  static const _partly = Icons.wb_cloudy;
  static const _cloud = Icons.cloud;
  static const _maybeRain = Icons.umbrella;
  static const _rain = Icons.water_drop;
  static const _storm = Icons.bolt;
  static const _fog = Icons.blur_on;
  static const _snow = Icons.ac_unit;

  static const Map<String, WeatherCondition> _table = {
    'ec': WeatherCondition('Encoberto com chuvas isoladas', _rain, Colors.blue),
    'ci': WeatherCondition('Chuvas isoladas', _rain, Colors.blue),
    'c': WeatherCondition('Chuva', _rain, Colors.blue),
    'in': WeatherCondition('Instável', _maybeRain, Colors.indigo),
    'pp': WeatherCondition(
        'Possibilidade de pancadas de chuva', _maybeRain, Colors.indigo),
    'cm': WeatherCondition('Chuva pela manhã', _rain, Colors.blue),
    'cn': WeatherCondition('Chuva à noite', _rain, Colors.blue),
    'pt': WeatherCondition('Pancadas de chuva à tarde', _rain, Colors.blue),
    'pm': WeatherCondition('Pancadas de chuva pela manhã', _rain, Colors.blue),
    'np': WeatherCondition('Nublado e pancadas de chuva', _rain, Colors.blue),
    'pc': WeatherCondition('Pancadas de chuva', _rain, Colors.blue),
    'pn': WeatherCondition('Parcialmente nublado', _partly, Colors.lightBlue),
    'cv': WeatherCondition('Chuvisco', _rain, Colors.blue),
    'ch': WeatherCondition('Chuvoso', _rain, Colors.blue),
    't': WeatherCondition('Tempestade', _storm, Colors.deepPurple),
    'ps': WeatherCondition('Predomínio de sol', _sun, Colors.amber),
    'e': WeatherCondition('Encoberto', _cloud, Colors.blueGrey),
    'n': WeatherCondition('Nublado', _cloud, Colors.blueGrey),
    'cl': WeatherCondition('Céu claro', _sun, Colors.amber),
    'nv': WeatherCondition('Nevoeiro', _fog, Colors.grey),
    'g': WeatherCondition('Geada', _snow, Colors.cyan),
    'ne': WeatherCondition('Neve', _snow, Colors.cyan),
    'nd': WeatherCondition('Não definido', Icons.help_outline, Colors.grey),
    'pnt': WeatherCondition('Pancadas de chuva à noite', _rain, Colors.blue),
    'psc': WeatherCondition('Possibilidade de chuva', _maybeRain, Colors.indigo),
    'pcm': WeatherCondition(
        'Possibilidade de chuva pela manhã', _maybeRain, Colors.indigo),
    'pct': WeatherCondition(
        'Possibilidade de chuva à tarde', _maybeRain, Colors.indigo),
    'pcn': WeatherCondition(
        'Possibilidade de chuva à noite', _maybeRain, Colors.indigo),
    'npt': WeatherCondition(
        'Nublado com pancadas à tarde', _rain, Colors.blue),
    'npn': WeatherCondition(
        'Nublado com pancadas à noite', _rain, Colors.blue),
    'ncn': WeatherCondition(
        'Nublado com possibilidade de chuva à noite', _maybeRain, Colors.indigo),
    'nct': WeatherCondition(
        'Nublado com possibilidade de chuva à tarde', _maybeRain, Colors.indigo),
    'ncm': WeatherCondition('Nublado com possibilidade de chuva pela manhã',
        _maybeRain, Colors.indigo),
    'npm': WeatherCondition(
        'Nublado com pancadas de chuva pela manhã', _rain, Colors.blue),
    'npp': WeatherCondition(
        'Nublado com possibilidade de chuva', _maybeRain, Colors.indigo),
    'vn': WeatherCondition('Variação de nebulosidade', _partly, Colors.lightBlue),
    'ct': WeatherCondition('Chuva à tarde', _rain, Colors.blue),
    'ppn': WeatherCondition(
        'Possibilidade de pancadas de chuva à noite', _maybeRain, Colors.indigo),
    'ppt': WeatherCondition(
        'Possibilidade de pancadas de chuva à tarde', _maybeRain, Colors.indigo),
    'ppm': WeatherCondition('Possibilidade de pancadas de chuva pela manhã',
        _maybeRain, Colors.indigo),
  };
}
