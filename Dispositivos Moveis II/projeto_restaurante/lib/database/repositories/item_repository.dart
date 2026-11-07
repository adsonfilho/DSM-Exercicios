import 'package:postgres/postgres.dart';
import '../database_provider.dart';
import '../../models/item_model.dart';

class ItemRepository {
  final dbProvider = DatabaseProvider.instance;

  Future<void> inserir(Item item) async {
    final conn = await dbProvider.connection;
    await conn.execute(
      Sql.named('INSERT INTO itens (nome, preco) VALUES (@nome, @preco)'),
      parameters: {'nome': item.nome, 'preco': item.preco},
    );
  }

  Future<List<Item>> listarTodos() async {
    final conn = await dbProvider.connection;
    final result = await conn.execute('SELECT id, nome, preco FROM itens ORDER BY nome ASC');
    
    return result.map((row) {
      return Item(
        id: row[0] as int,
        nome: row[1] as String,
        preco: double.tryParse(row[2].toString()) ?? 0.0, 
      );
    }).toList();
  }

  Future<void> atualizar(Item item) async {
    final conn = await dbProvider.connection;
    await conn.execute(
      Sql.named('UPDATE itens SET nome = @nome, preco = @preco WHERE id = @id'),
      parameters: {
        'nome': item.nome, 
        'preco': item.preco, 
        'id': item.id
      },
    );
  }

  Future<void> deletar(int id) async {
    final conn = await dbProvider.connection;
    await conn.execute(
      Sql.named('DELETE FROM itens WHERE id = @id'),
      parameters: {'id': id},
    );
  }
}