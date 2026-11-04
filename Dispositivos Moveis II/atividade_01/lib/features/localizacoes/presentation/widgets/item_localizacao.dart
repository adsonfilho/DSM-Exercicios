import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/localizacao.dart';

class ItemLocalizacao extends StatelessWidget {
  final Localizacao localizacao;

  const ItemLocalizacao({super.key, required this.localizacao});

  @override
  Widget build(BuildContext context) {
    final DateTime dataHoraUtc = DateTime.parse(localizacao.instante);
    final DateTime dataHoraLocal = dataHoraUtc.toLocal();
    final String dataFormatada = DateFormat('dd/MM/yyyy HH:mm:ss').format(dataHoraLocal);

    final String latStr = localizacao.latitude.toStringAsFixed(6);
    final String lngStr = localizacao.longitude.toStringAsFixed(6);
    final String precisaoStr = localizacao.precisao.toStringAsFixed(1);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.location_pin, color: Colors.blue),
        title: Text(
          dataFormatada,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Lat: $latStr | Lng: $lngStr\nPrecisão: $precisaoStr m',
        ),
      ),
    );
  }
}