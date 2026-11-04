import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  // Garante que os bindings do Flutter estão inicializados antes de chamar código nativo (como permissões)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}