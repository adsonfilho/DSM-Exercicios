import 'package:postgres/postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  Connection? _connection;

  DatabaseProvider._init();

  Future<Connection> get connection async {
    if (_connection != null && _connection!.isOpen) return _connection!;
    
    _connection = await Connection.open(
      Endpoint(
        host: dotenv.get('PGHOST'), 
        database: dotenv.get('PGDATABASE'),                                   
        username: dotenv.get('PGUSER'),                              
        password: dotenv.get('PGPASSWORD')
      ),
      settings: const ConnectionSettings(
        sslMode: SslMode.require,
      ),
    );
    return _connection!;
  }
}