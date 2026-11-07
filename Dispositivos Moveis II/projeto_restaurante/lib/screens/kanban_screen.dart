import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../models/pedido_model.dart';
import '../database/repositories/pedido_repository.dart';

class KanbanScreen extends StatefulWidget {
  const KanbanScreen({super.key});

  @override
  State<KanbanScreen> createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  final _pedidoRepository = PedidoRepository();
  List<Pedido> _pedidos = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _carregarPedidos();
    _iniciarPolling();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _carregarPedidos() async {
    final pedidos = await _pedidoRepository.listarAtivos();
    if (mounted) setState(() => _pedidos = pedidos);
  }

  void _iniciarPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _carregarPedidos(),
    );
  }

  Future<void> _avancarStatus(Pedido pedido) async {
    if (pedido.status == 'A FAZER') {
      await _pedidoRepository.atualizarStatus(pedido.id!, 'PREPARANDO');
    } else if (pedido.status == 'PREPARANDO') {
      await _pedidoRepository.atualizarStatus(pedido.id!, 'PRONTO');
    }
    _carregarPedidos();
  }

  Future<void> _finalizarPedido(Pedido pedido) async {
    await _pedidoRepository.atualizarStatus(pedido.id!, 'ENTREGUE');
    _carregarPedidos();
  }

  @override
  Widget build(BuildContext context) {
    final aFazer = _pedidos.where((p) => p.status == 'A FAZER').toList();
    final emPreparo = _pedidos.where((p) => p.status == 'PREPARANDO').toList();
    final pronto = _pedidos.where((p) => p.status == 'PRONTO').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fila da Cozinha'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, 
          children: [
            Expanded(
              child: _colunaKanban(
                'A FAZER',
                Colors.red,
                aFazer,
                'Começar',
                acao: _avancarStatus,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _colunaKanban(
                'PREPARANDO',
                Colors.orange,
                emPreparo,
                'Pronto',
                acao: _avancarStatus,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _colunaKanban(
                'PRONTO',
                Colors.green,
                pronto,
                'Finalizar',
                acao: _finalizarPedido,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colunaKanban(
    String titulo,
    Color cor,
    List<Pedido> lista,
    String textoBotao, {
    required Function(Pedido) acao,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Text(
              '$titulo (${lista.length})',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final p = lista[index];

                String horario = '';
                if (p.criadoEm != null) {
                  horario = DateFormat('HH:mm').format(p.criadoEm!.toLocal());
                }

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mesa ${p.mesa}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (horario.isNotEmpty)
                              Text(
                                horario,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        const Divider(),
                        Text(
                          p.itensResumo,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => acao(p),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cor,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              textoBotao,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
