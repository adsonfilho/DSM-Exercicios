import 'package:flutter/material.dart';
import '../../models/localizacao.dart';
import '../../data/repositories/repositorio_localizacoes.dart';
import '../widgets/mapa_localizacoes.dart';

class TelaMapa extends StatefulWidget {
  const TelaMapa({super.key});

  @override
  State<TelaMapa> createState() => _TelaMapaState();
}

class _TelaMapaState extends State<TelaMapa> {
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
        const SnackBar(content: Text('Erro ao carregar os dados para o mapa.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa Interativo')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _localizacoes.isEmpty
              ? const Center(
                  child: Text('Nenhuma localização salva para exibir no mapa.'),
                )
              : MapaLocalizacoes(
                  localizacoes: _localizacoes,
                  onAtualizar: _carregarDados, 
                ),
    );
  }
}