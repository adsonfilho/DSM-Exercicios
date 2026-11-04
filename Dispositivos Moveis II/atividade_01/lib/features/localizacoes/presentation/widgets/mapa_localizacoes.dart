import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../models/localizacao.dart';

class MapaLocalizacoes extends StatefulWidget {
  final List<Localizacao> localizacoes;
  final VoidCallback onAtualizar;

  const MapaLocalizacoes({
    super.key,
    required this.localizacoes,
    required this.onAtualizar,
  });

  @override
  State<MapaLocalizacoes> createState() => _MapaLocalizacoesState();
}

class _MapaLocalizacoesState extends State<MapaLocalizacoes> {
  final MapController _controladorMapa = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _enquadrarPontos();
    });
  }

  void _enquadrarPontos() {
    if (widget.localizacoes.isEmpty) return;

    if (widget.localizacoes.length == 1) {
      final loc = widget.localizacoes.first;
      _controladorMapa.move(LatLng(loc.latitude, loc.longitude), 16.0);
      return;
    }

    final pontos = widget.localizacoes
        .map((loc) => LatLng(loc.latitude, loc.longitude))
        .toList();

    final bounds = LatLngBounds.fromPoints(pontos);

    _controladorMapa.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(50.0)),
    );
  }

  @override
  void dispose() {
    _controladorMapa.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _controladorMapa,
          options: const MapOptions(initialZoom: 15.0),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName:
                  'com.seu_usuario.localizacoes', 
            ),
            MarkerLayer(
              markers: List.generate(widget.localizacoes.length, (index) {
                final loc = widget.localizacoes[index];
                final isMaisRecente = index == 0;

                return Marker(
                  point: LatLng(loc.latitude, loc.longitude),
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.location_pin,
                    color: isMaisRecente ? Colors.red : Colors.blue,
                    size: isMaisRecente ? 40 : 30,
                  ),
                );
              }),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'btnEnquadrar',
                onPressed: _enquadrarPontos,
                tooltip: 'Enquadrar todos os pontos',
                child: const Icon(Icons.center_focus_strong),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                heroTag: 'btnAtualizar',
                onPressed: widget.onAtualizar,
                tooltip: 'Atualizar registos',
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
