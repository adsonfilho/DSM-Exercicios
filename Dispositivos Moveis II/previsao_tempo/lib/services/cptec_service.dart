import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/forecast.dart';
import '../utils/text_utils.dart';
import 'app_exceptions.dart';
import 'cptec_parser.dart';

/// Cliente HTTP do webservice XML do CPTEC/INPE.
///
/// Documentação: http://servicos.cptec.inpe.br/XML/
class CptecService {
  CptecService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _base = 'http://servicos.cptec.inpe.br/XML';
  static const _timeout = Duration(seconds: 15);

  /// `GET /listaCidades?city=<nome>`
  Future<List<City>> searchCities(String query) async {
    final q = Uri.encodeComponent(removeDiacritics(query.trim()));
    final body = await _get(Uri.parse('$_base/listaCidades?city=$q'));
    return CptecParser.parseCities(body);
  }

  /// `GET /cidade/{id}/previsao.xml` (previsão para 4 dias)
  Future<Forecast> fetchForecast(City city) async {
    final body = await _get(Uri.parse('$_base/cidade/${city.id}/previsao.xml'));
    return CptecParser.parseForecast(body, city);
  }

  Future<String> _get(Uri uri) async {
    try {
      final response = await _client.get(uri).timeout(_timeout);
      if (response.statusCode != 200) {
        throw ServiceUnavailable(response.statusCode);
      }
      if (response.bodyBytes.isEmpty) throw InvalidResponse();
      return _decode(response.bodyBytes);
    } on TimeoutException {
      throw ConnectionFailure();
    } on SocketException {
      throw ConnectionFailure();
    } on http.ClientException {
      throw ConnectionFailure();
    } on HandshakeException {
      throw ConnectionFailure();
    }
  }

  String _decode(List<int> bytes) {
    try {
      return utf8.decode(bytes);
    } on FormatException {
      return latin1.decode(bytes);
    }
  }

  void dispose() => _client.close();
}

final cptecService = CptecService();
