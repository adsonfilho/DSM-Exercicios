import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../models/pedido_model.dart';
import '../database/repositories/item_repository.dart';
import '../database/repositories/pedido_repository.dart';

class AnotarPedidoScreen extends StatefulWidget {
  const AnotarPedidoScreen({super.key});

  @override
  State<AnotarPedidoScreen> createState() => _AnotarPedidoScreenState();
}

class _AnotarPedidoScreenState extends State<AnotarPedidoScreen> {
  final _itemRepository = ItemRepository();
  final _pedidoRepository = PedidoRepository();

  final _mesaController = TextEditingController();
  List<Item> _itensCardapio = [];
  final List<String> _itensSelecionados = [];

  @override
  void initState() {
    super.initState();
    _carregarItens();
  }

  Future<void> _carregarItens() async {
    final itens = await _itemRepository.listarTodos();
    if (mounted) setState(() => _itensCardapio = itens);
  }

  void _adicionarItemComQuantidade(Item item) {
    int qtdTemp = 1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Adicionar ${item.nome}'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 36),
                    onPressed: () {
                      if (qtdTemp > 1) setStateDialog(() => qtdTemp--);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$qtdTemp',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 36),
                    onPressed: () => setStateDialog(() => qtdTemp++),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () => _itensSelecionados.add('${qtdTemp}x ${item.nome}'),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _enviarPedido() async {
    if (_mesaController.text.isEmpty || _itensSelecionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha a mesa e adicione itens.')),
      );
      return;
    }

    String resumo = _itensSelecionados.join('\n');
    final pedido = Pedido(
      mesa: _mesaController.text,
      itensResumo: resumo,
      status: 'A FAZER',
    );
    await _pedidoRepository.inserir(pedido);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pedido enviado para a cozinha!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anotar Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _mesaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número da Mesa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cardápio:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: _itensCardapio.length,
                itemBuilder: (context, index) {
                  final item = _itensCardapio[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.nome),
                      subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}'),
                      trailing: const Icon(
                        Icons.add_circle,
                        color: Colors.teal,
                      ),
                      onTap: () => _adicionarItemComQuantidade(item),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Resumo do Pedido (${_itensSelecionados.length} itens):',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _itensSelecionados
                    .map(
                      (i) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text(i),
                          onDeleted: () =>
                              setState(() => _itensSelecionados.remove(i)),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _enviarPedido,
                icon: const Icon(Icons.send),
                label: const Text(
                  'Enviar para Cozinha',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
