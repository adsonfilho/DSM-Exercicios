import 'package:postgres/postgres.dart';
import '../database_provider.dart';
import '../../models/pedido_model.dart';

class PedidoRepository {
  final dbProvider = DatabaseProvider.instance;

  Future<void> inserir(Pedido pedido) async {
    final conn = await dbProvider.connection;
    await conn.execute(
      Sql.named('INSERT INTO pedidos (mesa, itens_resumo, status) VALUES (@mesa, @itens, @status)'),
      parameters: {'mesa': pedido.mesa, 'itens': pedido.itensResumo, 'status': pedido.status},
    );
  }

  Future<List<Pedido>> listarAtivos() async {
    final conn = await dbProvider.connection;
    final result = await conn.execute('''
      SELECT id, mesa, itens_resumo, status, criado_em 
      FROM pedidos 
      WHERE status != 'ENTREGUE' 
      ORDER BY id ASC
    ''');
    
    return result.map((row) {
      return Pedido(
        id: row[0] as int,
        mesa: row[1] as String,
        itensResumo: row[2] as String,
        status: row[3] as String,
        criadoEm: row[4] as DateTime?,
      );
    }).toList();
  }

  Future<void> atualizarStatus(int id, String novoStatus) async {
    final conn = await dbProvider.connection;
    await conn.execute(
      Sql.named('UPDATE pedidos SET status = @status WHERE id = @id'),
      parameters: {'status': novoStatus, 'id': id},
    );
  }
}