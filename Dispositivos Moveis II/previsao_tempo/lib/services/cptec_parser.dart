import 'package:xml/xml.dart';

import '../models/city.dart';
import '../models/forecast.dart';
import 'app_exceptions.dart';

class CptecParser {

  static List<City> parseCities(String xml) {
    final doc = _parse(xml);
    if (doc.rootElement.name.local != 'cidades') throw InvalidResponse();

    final cities = <City>[];
    for (final el in doc.rootElement.findElements('cidade')) {
      final id = int.tryParse(_text(el, 'id') ?? '');
      final name = _text(el, 'nome');
      final uf = _text(el, 'uf') ?? '';
      if (id == null || name == null) continue; 
      cities.add(City(id: id, name: name, state: uf));
    }
    return cities;
  }

  static Forecast parseForecast(String xml, City city, {DateTime? now}) {
    final doc = _parse(xml);
    final root = doc.rootElement;
    if (root.name.local != 'cidade') throw InvalidResponse();

    final days = <DayForecast>[];
    for (final p in root.findElements('previsao')) {
      final day = DayForecast(
        date: _date(_text(p, 'dia')),
        minTemp: _int(_text(p, 'minima')),
        maxTemp: _int(_text(p, 'maxima')),
        conditionCode: _text(p, 'tempo')?.toLowerCase(),
        uvIndex: _double(_text(p, 'iuv')),
      );
      // ignora blocos completamente vazios
      if (day.date == null &&
          day.minTemp == null &&
          day.maxTemp == null &&
          day.conditionCode == null) {
        continue;
      }
      days.add(day);
    }

    if (days.isEmpty) throw NoForecastAvailable();

    return Forecast(
      city: city,
      updatedAt: _date(_text(root, 'atualizacao')),
      days: days,
      fetchedAt: now ?? DateTime.now(),
    );
  }


  static XmlDocument _parse(String xml) {
    try {
      return XmlDocument.parse(xml);
    } on XmlException {
      throw InvalidResponse();
    }
  }

  static String? _text(XmlElement parent, String tag) {
    final found = parent.findElements(tag);
    if (found.isEmpty) return null;
    final value = found.first.innerText.trim();
    if (value.isEmpty) return null;
    final lower = value.toLowerCase();
    if (lower == 'null' || lower == 'undefined') return null;
    return value;
  }

  static int? _int(String? s) => s == null ? null : double.tryParse(s)?.round();

  static double? _double(String? s) => s == null ? null : double.tryParse(s);

  static DateTime? _date(String? s) => s == null ? null : DateTime.tryParse(s);
}
