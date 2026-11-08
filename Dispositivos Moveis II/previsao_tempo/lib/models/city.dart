/// Localidade retornada pelo serviço do CPTEC/INPE.
class City {
  final int id;
  final String name;
  final String state;

  const City({required this.id, required this.name, required this.state});

  /// Ex.: "São Paulo - SP"
  String get label => state.isEmpty ? name : '$name - $state';

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'state': state};

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'] as int,
        name: json['name'] as String,
        state: (json['state'] as String?) ?? '',
      );

  @override
  bool operator ==(Object other) => other is City && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
