import 'package:flutter/material.dart';
import 'participante.dart';
import 'utils.dart';
import 'tela_resumo.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});
  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();

  void _exibirDados() {
    final formularioValido = _formKey.currentState!.validate();

    if (!formularioValido) {
      return;
    }

    final participante = Participante(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      cpf: _cpfController.text.trim(),
    );

    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TelaResumo(participante: participante),
      ),
    );
  }

  void _limpar() {
    _formKey.currentState!.reset();
    _nomeController.clear();
    _emailController.clear();
    _telefoneController.clear();
    _cpfController.clear(); 
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de participante')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Informe os dados do participante.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Ex.: Adson Filho',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Ex.: adsonfilho@email.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                validator: validarEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: 'Ex.: (11) 99999-9999',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: validarTelefone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Ex.: 123.456.789-00',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: validarCPF,
                onFieldSubmitted: (_) => _exibirDados(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed:  _exibirDados,
                child: const Text('Exibir dados'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: _limpar, child: const Text('Limpar')),
            ],
          ),
        ),
      ),
    );
  }
}