import 'package:flutter/material.dart';
import 'cadastro_participante.dart';
void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de estudante',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TelaCadastro(),
    );
  }
}
