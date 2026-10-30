// Converte uma data no formato DD/MM/AAAA em DateTime.
// Retorna null quando o texto não representa uma data válida.
DateTime? converterData(String texto) {
  final formato = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!formato.hasMatch(texto)) {
    return null;
  }
  final partes = texto.split('/');
  final dia = int.parse(partes[0]);
  final mes = int.parse(partes[1]);
  final ano = int.parse(partes[2]);
  if (ano < 1) {
    return null;
  }
  final data = DateTime(ano, mes, dia);
  // DateTime ajusta valores fora dos limites.
  // A comparação permite rejeitar datas como 31/02/2000.
  if (data.day != dia || data.month != mes || data.year != ano) {
    return null;
  }
  return data;
}

String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  final ano = data.year.toString().padLeft(4, '0');
  return '$dia/$mes/$ano';
}

String? validarNome(String? valor) {
  final nome = valor?.trim() ?? '';
  if (nome.isEmpty) {
    return 'Informe o nome.';
  }
  if (nome.length < 3) {
    return 'O nome deve ter pelo menos três caracteres.';
  }
  return null;
}

String? validarEmail(String? valor) {
  final email = valor?.trim() ?? '';
  if (email.isEmpty) {
    return 'Informe o e-mail.';
  }
  // Verificação simplificada para fins didáticos.
  final formato = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!formato.hasMatch(email)) {
    return 'Informe um e-mail válido.';
  }
  return null;
}

String? validarData(String? valor) {
  final texto = valor?.trim() ?? '';
  if (texto.isEmpty) {
    return 'Informe a data de nascimento.';
  }
  final data = converterData(texto);
  if (data == null) {
    return 'Informe uma data válida no formato DD/MM/AAAA.';
  }
  final agora = DateTime.now();
  final hoje = DateTime(agora.year, agora.month, agora.day);
  if (data.isAfter(hoje)) {
    return 'A data de nascimento não pode estar no futuro.';
  }
  return null;
}

String? validarTelefone(String? valor) {
  final telefone = valor?.trim() ?? '';
  if (telefone.isEmpty) {
    return 'Informe o telefone.';
  }
  final formato = RegExp(r'^\(\d{2}\)\s?\d{4,5}-\d{4}$');
  if (!formato.hasMatch(telefone)) {
    return 'Informe um telefone válido no formato (XX) XXXXX-XXXX.';
  }
  return null;
}

String? validarCPF(String? valor) {
  final cpf = valor?.trim() ?? '';
  if (cpf.isEmpty) {
    return 'Informe o CPF.';
  }
  if(cpf.length != 11) {
    return 'Informe um CPF válido com 11 dígitos.';
  }
  return null;
}