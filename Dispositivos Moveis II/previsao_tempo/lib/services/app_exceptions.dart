abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class ConnectionFailure extends AppException {
  ConnectionFailure()
      : super('Não foi possível conectar ao serviço. Verifique sua conexão '
            'com a internet e tente novamente.');
}

class ServiceUnavailable extends AppException {
  ServiceUnavailable([int? statusCode])
      : super('O serviço do CPTEC/INPE está indisponível no momento'
            '${statusCode != null ? ' (código $statusCode)' : ''}. '
            'Tente novamente mais tarde.');
}

class InvalidResponse extends AppException {
  InvalidResponse()
      : super('O serviço retornou uma resposta inválida. '
            'Tente novamente mais tarde.');
}

class NoForecastAvailable extends AppException {
  NoForecastAvailable()
      : super('Não há previsão disponível para esta cidade no momento.');
}
