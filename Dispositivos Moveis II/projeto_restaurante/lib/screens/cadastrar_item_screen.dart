import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../database/repositories/item_repository.dart';

class CadastrarItemScreen extends StatefulWidget {
  const CadastrarItemScreen({super.key});

  @override
  State<CadastrarItemScreen> createState() => _CadastrarItemScreenState();
}

class _CadastrarItemScreenState extends State<CadastrarItemScreen> {
  final _itemRepository = ItemRepository();
  List<Item> _itens = [];

  @override
  void initState() {
    super.initState();
    _carregarItens();
  }

  Future<void> _carregarItens() async {
    final itens = await _itemRepository.listarTodos();
    if (mounted) setState(() => _itens = itens);
  }

  Future<void> _deletarItem(int id) async {
    bool confirmar = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Produto'),
        content: const Text('Tem a certeza que deseja excluir este item do cardápio?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(context, true), 
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ?? false;

    if (confirmar) {
      await _itemRepository.deletar(id);
      _carregarItens();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item excluído com sucesso.')));
      }
    }
  }

  void _abrirFormulario({Item? itemParaEditar}) {
    final nomeController = TextEditingController(text: itemParaEditar?.nome ?? '');
    final precoController = TextEditingController(text: itemParaEditar?.preco.toStringAsFixed(2) ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(itemParaEditar == null ? 'Novo Item' : 'Editar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Produto', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: precoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Preço (R\$)', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Cancelar')
            ),
            ElevatedButton(
              onPressed: () async {
                if (nomeController.text.isEmpty || precoController.text.isEmpty) return;

                double precoFormatado = double.tryParse(precoController.text.replaceAll(',', '.')) ?? 0.0;

                if (itemParaEditar == null) {
                  final novoItem = Item(nome: nomeController.text, preco: precoFormatado);
                  await _itemRepository.inserir(novoItem);
                } else {
                  final itemAtualizado = Item(
                    id: itemParaEditar.id, 
                    nome: nomeController.text, 
                    preco: precoFormatado
                  );
                  await _itemRepository.atualizar(itemAtualizado);
                }

                if (context.mounted) Navigator.pop(context);
                _carregarItens();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
              child: const Text('Salvar'),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão do Cardápio')),
      body: _itens.isEmpty 
        ? const Center(child: Text('Nenhum item cadastrado.'))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _itens.length,
            itemBuilder: (context, index) {
              final item = _itens[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(item.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text('R\$ ${item.preco.toStringAsFixed(2)}', style: const TextStyle(color: Colors.teal, fontSize: 16)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _abrirFormulario(itemParaEditar: item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletarItem(item.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Novo Produto'),
      ),
    );
  }
}