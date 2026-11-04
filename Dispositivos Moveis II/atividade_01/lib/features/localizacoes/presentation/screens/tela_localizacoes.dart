import 'package:flutter/material.dart';
import '../../models/localizacao.dart';
import '../../data/repositories/repositorio_localizacoes.dart';
import '../widgets/item_localizacao.dart';

class TelaLocalizacoes extends StatefulWidget {
  final bool coletaAtiva; // Recebe o estado para avisar na exclusão

  const TelaLocalizacoes({super.key, required this.coletaAtiva});

  @override
  State<TelaLocalizacoes> createState() => _TelaLocalizacoesState();
}

class _TelaLocalizacoesState extends State<TelaLocalizacoes> {
  final RepositorioLocalizacoes _repositorio = RepositorioLocalizacoes();
  List<Localizacao> _localizacoes = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() => _carregando = true);
    try {
      final dados = await _repositorio.consultarTodas();
      if (!mounted) return;
      setState(() {
        _localizacoes = dados;
        _carregando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar o histórico.')),
      );
    }
  }

  Future<void> _confirmarExclusao() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Limpar histórico'),
          content: Text(
            'Esta operação é permanente e apagará todos os registos do banco.\n\n'
            '${widget.coletaAtiva ? 'Atenção: Como a coleta está ativa, os novos registos continuarão a ser salvos.' : ''}'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Limpar histórico',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await _limparHistorico();
    }
  }

  Future<void> _limparHistorico() async {
    try {
      await _repositorio.limparHistorico();
      if (!mounted) return;
      
      await _carregarDados(); 
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Histórico limpo com sucesso!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao limpar o histórico.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _carregarDados,
            tooltip: 'Atualizar Registos',
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _confirmarExclusao,
            tooltip: 'Limpar histórico',
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _localizacoes.isEmpty
              ? const Center(child: Text('Nenhuma localização salva.'))
              : ListView.builder(
                  itemCount: _localizacoes.length, 
                  itemBuilder: (context, index) {
                    return ItemLocalizacao(localizacao: _localizacoes[index]);
                  },
                ),
    );
  }
}