class Pedido {
  int? id;
  String mesa;
  String itensResumo;
  String status;
  DateTime? criadoEm;

  Pedido({
    this.id,
    required this.mesa,
    required this.itensResumo,
    this.status = 'A FAZER',
    this.criadoEm,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mesa': mesa,
      'itensResumo': itensResumo,
      'status': status,
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      mesa: map['mesa'],
      itensResumo: map['itensResumo'],
      status: map['status'],
    );
  }
}
