import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/localizacao.dart';
import '../../data/repositories/repositorio_localizacoes.dart';
import '../../services/servico_localizacao.dart';
import 'tela_localizacoes.dart';
import 'tela_mapa.dart';

class TelaColeta extends StatefulWidget {
  const TelaColeta({super.key});

  @override
  State<TelaColeta> createState() => _TelaColetaState();
}

class _TelaColetaState extends State<TelaColeta> {
  final ServicoLocalizacao _servicoLocalizacao = ServicoLocalizacao();
  final RepositorioLocalizacoes _repositorio = RepositorioLocalizacoes();

  StreamSubscription<Position>? _assinaturaPosicao;
  bool _coletando = false;

  Future<void> _iniciarColeta() async {
    final permissoesOk = await _servicoLocalizacao.verificarPermissoes();

    if (!permissoesOk) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Permissão de localização negada ou GPS desativado. Verifique as configurações.',
          ),
        ),
      );
      return;
    }

    if (_assinaturaPosicao != null) {
      await _assinaturaPosicao!.cancel();
    }

    setState(() {
      _coletando = true;
    });

    _assinaturaPosicao = _servicoLocalizacao.obterStreamPosicoes().listen(
      (Position posicao) async {
        final novaLocalizacao = Localizacao(
          latitude: posicao.latitude,
          longitude: posicao.longitude,
          precisao: posicao.accuracy,
          instante: DateTime.now()
              .toUtc()
              .toIso8601String(), 
        );

        await _repositorio.inserir(novaLocalizacao);
        debugPrint('Posição salva: ${posicao.latitude}, ${posicao.longitude}');
      },
      onError: (erro) {
        debugPrint('Erro no stream de localização: $erro');
      },
    );
  }

  Future<void> _pararColeta() async {
    if (_assinaturaPosicao != null) {
      await _assinaturaPosicao!.cancel();
      _assinaturaPosicao = null;
    }
    setState(() {
      _coletando = false;
    });
  }

  @override
  void dispose() {
    _assinaturaPosicao?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coleta de Localizações')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                _coletando ? Icons.location_on : Icons.location_off,
                size: 80,
                color: _coletando ? Colors.green : Colors.grey,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar coleta'),
                onPressed: _coletando ? null : _iniciarColeta,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.stop),
                label: const Text('Parar coleta'),
                onPressed: !_coletando ? null : _pararColeta,
              ),
              const Divider(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('Consultar histórico'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TelaLocalizacoes(coletaAtiva: _coletando),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Ver mapa'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TelaMapa()),
                  );
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.settings),
                label: const Text('Configurações de permissão'),
                onPressed: _servicoLocalizacao.abrirConfiguracoes,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
