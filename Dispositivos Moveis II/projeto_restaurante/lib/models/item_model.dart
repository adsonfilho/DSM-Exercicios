class Item {
  int? id;
  String nome;
  double preco;

  Item({this.id, required this.nome, required this.preco});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'preco': preco};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(id: map['id'], nome: map['nome'], preco: map['preco']);
  }
}
