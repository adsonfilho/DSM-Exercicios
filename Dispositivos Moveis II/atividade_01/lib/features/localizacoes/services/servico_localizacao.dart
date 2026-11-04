import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

class ServicoLocalizacao {
  Future<bool> verificarPermissoes() async {
    bool servicoHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicoHabilitado) {
      return false; 
    }

    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return false; 
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return false; 
    }

    return true;
  }

  Future<void> abrirConfiguracoes() async {
    await Geolocator.openAppSettings();
  }

  Stream<Position> obterStreamPosicoes() {
    LocationSettings configuracoes;

    if (defaultTargetPlatform == TargetPlatform.android) {
      configuracoes = AndroidSettings(
        accuracy: LocationAccuracy.high, 
        intervalDuration: const Duration(seconds: 20), 
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "A recolher a localização em segundo plano.",
          notificationTitle: "Coleta Ativa",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      configuracoes = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
      );
    } else {
      configuracoes = const LocationSettings(
        accuracy: LocationAccuracy.high,
      );
    }

    return Geolocator.getPositionStream(locationSettings: configuracoes);
  }
}