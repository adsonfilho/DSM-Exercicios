import 'package:flutter/material.dart';

import '../models/city.dart';
import '../models/forecast.dart';
import '../services/app_exceptions.dart';
import '../services/cptec_service.dart';
import '../services/storage_service.dart';
import '../utils/date_utils.dart';
import '../widgets/day_card.dart';
import '../widgets/message_view.dart';
import '../widgets/source_footer.dart';
import 'chart_screen.dart';

/// Tela 2: previsão de 4 dias da cidade selecionada.
class ForecastScreen extends StatefulWidget {
  final City city;

  const ForecastScreen({super.key, required this.city});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  Forecast? _forecast;
  bool _loading = true;
  String? _error;
  String? _cacheNotice; // preenchido quando exibimos dados salvos localmente

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final forecast = await cptecService.fetchForecast(widget.city);
      await storageService.saveForecast(forecast);
      if (!mounted) return;
      setState(() {
        _forecast = forecast;
        _cacheNotice = null;
        _loading = false;
      });
    } on NoForecastAvailable catch (e) {
      if (!mounted) return;
      setState(() {
        _forecast = null;
        _cacheNotice = null;
        _error = e.message;
        _loading = false;
      });
    } on AppException catch (e) {
      await _fallbackToCache(e.message);
    } catch (_) {
      await _fallbackToCache(
          'Ocorreu um erro inesperado ao consultar a previsão.');
    }
  }

  /// Em caso de falha, tenta exibir a última previsão salva no dispositivo.
  Future<void> _fallbackToCache(String message) async {
    final cached =
        _forecast ?? await storageService.loadForecast(widget.city.id);
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (cached != null) {
        _forecast = cached;
        _cacheNotice = '$message\nExibindo dados salvos em '
            '${formatDate(cached.fetchedAt)}.';
      } else {
        _forecast = null;
        _error = message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final forecast = _forecast;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.label),
        actions: [
          IconButton(
            tooltip: 'Atualizar previsão',
            icon: const Icon(Icons.refresh),
            onPressed: _loading ? null : _load,
          ),
          IconButton(
            tooltip: 'Ver gráfico de temperatura',
            icon: const Icon(Icons.show_chart),
            onPressed: forecast == null ? null : () => _openChart(forecast),
          ),
        ],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  void _openChart(Forecast forecast) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChartScreen(forecast: forecast)),
    );
  }

  Widget _buildBody() {
    final forecast = _forecast;

    if (forecast == null) {
      if (_loading) return const Center(child: CircularProgressIndicator());
      return RefreshIndicator(
        onRefresh: _load,
        child: MessageView(
          icon: Icons.cloud_off,
          message: _error ?? 'Não há previsão disponível.',
          actionLabel: 'Tentar novamente',
          onAction: _load,
        ),
      );
    }

    return Column(
      children: [
        if (_loading) const LinearProgressIndicator(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                _header(forecast),
                if (_cacheNotice != null) _notice(_cacheNotice!),
                const SizedBox(height: 8),
                for (final day in forecast.days) DayCard(day: day),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => _openChart(forecast),
                  icon: const Icon(Icons.show_chart),
                  label: const Text('Ver gráfico de temperatura'),
                ),
                const SourceFooter(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(Forecast forecast) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(forecast.city.name, style: theme.textTheme.headlineSmall),
        Text(
          forecast.city.state.isEmpty ? '' : forecast.city.state,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          forecast.updatedAt == null
              ? 'Data de atualização não informada'
              : 'Atualizado em ${formatDate(forecast.updatedAt)}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _notice(String text) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.wifi_off),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
