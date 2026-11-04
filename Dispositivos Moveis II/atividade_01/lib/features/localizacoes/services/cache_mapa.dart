import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheMapa {
  static Future<String> prepararPastaCache() async {
    final diretorio = await getApplicationDocumentsDirectory();
    final pastaCache = Directory('${diretorio.path}/map_cache');
    
    if (!await pastaCache.exists()) {
      await pastaCache.create(recursive: true);
    }
    
    return pastaCache.path;
  }
}