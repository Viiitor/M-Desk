class Categoria {
  final int id;
  final String nome;

  Categoria({required this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }
}
