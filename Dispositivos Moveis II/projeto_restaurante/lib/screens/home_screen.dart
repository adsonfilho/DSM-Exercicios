import 'package:flutter/material.dart';

import 'anotar_pedido_screen.dart';
import 'kanban_screen.dart';
import 'cadastrar_item_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante App'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _btnMenu(
                context,
                'Anotar Pedidos',
                Icons.note_add,
                const AnotarPedidoScreen(),
              ),
              const SizedBox(height: 20),
              _btnMenu(
                context,
                'Dashboard Cozinha',
                Icons.kitchen,
                const KanbanScreen(),
              ),
              const SizedBox(height: 20),
              _btnMenu(
                context,
                'Cardápio',
                Icons.restaurant_menu,
                const CadastrarItemScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnMenu(
    BuildContext context,
    String texto,
    IconData icone,
    Widget tela,
  ) {
    return ElevatedButton.icon(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => tela)),
      icon: Icon(icone, size: 28),
      label: Text(texto, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
