import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/city.dart';
import '../models/forecast.dart';

class StorageService {
  static const _selectedKey = 'selected_city';
  static const _recentKey = 'recent_cities';
  static const _maxRecent = 8;

  static String _forecastKey(int cityId) => 'forecast_$cityId';

  Future<void> saveSelectedCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedKey, jsonEncode(city.toJson()));
  }

  Future<City?> loadSelectedCity() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_selectedKey);
      if (raw == null) return null;
      return City.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null; 
    }
  }

  Future<List<City>> loadRecentCities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_recentKey);
      if (raw == null) return [];
      return (jsonDecode(raw) as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> addRecentCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await loadRecentCities();
    list.removeWhere((c) => c.id == city.id);
    list.insert(0, city);
    final trimmed = list.take(_maxRecent).toList();
    await prefs.setString(
        _recentKey, jsonEncode(trimmed.map((c) => c.toJson()).toList()));
  }

  Future<void> saveForecast(Forecast forecast) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _forecastKey(forecast.city.id), jsonEncode(forecast.toJson()));
  }

  Future<Forecast?> loadForecast(int cityId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_forecastKey(cityId));
      if (raw == null) return null;
      return Forecast.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}

final storageService = StorageService();
