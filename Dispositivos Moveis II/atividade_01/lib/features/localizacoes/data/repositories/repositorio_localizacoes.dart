import '../database/banco_localizacoes.dart';
import '../../models/localizacao.dart';

class RepositorioLocalizacoes {
  Future<void> inserir(Localizacao localizacao) async {
    final db = await BancoLocalizacoes.banco;
    await db.insert('localizacoes', localizacao.toMap());
  }

  Future<List<Localizacao>> consultarTodas() async {
    final db = await BancoLocalizacoes.banco;
    final List<Map<String, dynamic>> mapas = await db.query(
      'localizacoes',
      orderBy: 'id DESC', 
      limit: 100,         
    );

    return List.generate(mapas.length, (i) {
      return Localizacao.fromMap(mapas[i]);
    });
  }

  Future<void> limparHistorico() async {
    final db = await BancoLocalizacoes.banco;
    await db.delete('localizacoes'); 
  }
}