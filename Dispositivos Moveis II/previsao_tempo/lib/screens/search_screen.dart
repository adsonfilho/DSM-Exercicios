import 'package:flutter/material.dart';

import '../models/city.dart';
import '../services/app_exceptions.dart';
import '../services/cptec_service.dart';
import '../services/storage_service.dart';
import '../widgets/source_footer.dart';
import 'forecast_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  bool _loading = false;
  bool _searched = false;
  String? _error;
  String _lastQuery = '';
  List<City> _results = [];
  List<City> _recent = [];
  int _requestId = 0; 

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _loadRecent();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_controller.text.trim().isEmpty &&
        (_searched || _error != null || _loading || _results.isNotEmpty)) {
      _requestId++; 
      setState(() {
        _loading = false;
        _searched = false;
        _error = null;
        _results = [];
      });
    } else {
      setState(() {}); 
    }
  }

  void _clear() {
    _controller.clear(); 
  }

  Future<void> _loadRecent() async {
    final recent = await storageService.loadRecentCities();
    if (!mounted) return;
    setState(() => _recent = recent);
  }

  Future<void> _search() async {
    FocusScope.of(context).unfocus();
    final query = _controller.text.trim();

    if (query.length < 2) {
      _requestId++;
      setState(() {
        _loading = false;
        _error = 'Digite pelo menos 2 letras do nome da cidade.';
        _searched = false;
        _results = [];
      });
      return;
    }

    final requestId = ++_requestId;
    setState(() {
      _loading = true;
      _error = null;
      _searched = false;
      _lastQuery = query;
    });

    try {
      final results = await cptecService.searchCities(query);
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _results = results;
        _searched = true;
        _loading = false;
      });
    } on AppException catch (e) {
      _fail(requestId, e.message);
    } catch (_) {
      _fail(requestId, 'Ocorreu um erro inesperado ao pesquisar a cidade.');
    }
  }

  void _fail(int requestId, String message) {
    if (!mounted || requestId != _requestId) return;
    setState(() {
      _loading = false;
      _results = [];
      _error = message;
    });
  }

  Future<void> _open(City city) async {
    await storageService.saveSelectedCity(city);
    await storageService.addRecentCity(city);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ForecastScreen(city: city)),
    );
    _loadRecent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Previsão do Tempo')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _search(),
                decoration: InputDecoration(
                  labelText: 'Nome da cidade',
                  hintText: 'Ex.: São José dos Campos',
                  border: const OutlineInputBorder(),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_controller.text.isNotEmpty)
                        IconButton(
                          tooltip: 'Limpar',
                          icon: const Icon(Icons.clear),
                          onPressed: _clear,
                        ),
                      IconButton(
                        tooltip: 'Pesquisar',
                        icon: const Icon(Icons.search),
                        onPressed: _loading ? null : _search,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: _buildContent()),
            const SourceFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final theme = Theme.of(context);
    final children = <Widget>[];

    if (_loading) {
      children.add(const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ));
    } else if (_error != null) {
      children.add(_InlineMessage(
          icon: Icons.error_outline, message: _error!));
    } else if (_searched) {
      if (_results.isEmpty) {
        children.add(_InlineMessage(
          icon: Icons.location_off_outlined,
          message: 'Nenhuma cidade encontrada para “$_lastQuery”.',
        ));
      } else {
        children.add(_header('Resultados (${_results.length})', theme));
        children.addAll(_results.map(
            (c) => _cityTile(c, Icons.location_city)));
      }
    }

    if (_recent.isNotEmpty) {
      if (children.isNotEmpty) children.add(const Divider(height: 24));
      children.add(_header('Cidades recentes', theme));
      children.addAll(_recent.map((c) => _cityTile(c, Icons.history)));
    }

    if (children.isEmpty) {
      return const _InlineMessage(
        icon: Icons.travel_explore,
        message: 'Pesquise uma cidade para ver a previsão do tempo.',
      );
    }

    return ListView(children: children);
  }

  Widget _header(String text, ThemeData theme) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Text(text, style: theme.textTheme.titleSmall),
      );

  Widget _cityTile(City city, IconData icon) => ListTile(
        leading: Icon(icon),
        title: Text(city.name),
        subtitle: Text(city.state.isEmpty ? 'UF não informada' : city.state),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _open(city),
      );
}

class _InlineMessage extends StatelessWidget {
  final IconData icon;
  final String message;

  const _InlineMessage({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 12),
          Text(message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}