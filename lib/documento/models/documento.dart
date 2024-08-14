class Documento {
  final String titulo;
  final String imagem;

  Documento({required this.titulo, required this.imagem});

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(
      titulo: json['tipo'],
      imagem: json['imagem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'imagem': imagem,
    };
  }

}
