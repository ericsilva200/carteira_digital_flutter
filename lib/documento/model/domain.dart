import 'dart:convert';

class Documento {
  String titulo;
  String imagem;

  Documento(this.titulo, this.imagem);

  Documento copyWith({String? titulo, String? imagem}) {
    return Documento(
      titulo ?? this.titulo,
      imagem ?? this.imagem,
    );
  }

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(json['titulo'], json['imagem']);
  }

  static Documento fromJsonString(String jsonString) {
    return Documento.fromJson(json.decode(jsonString));
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'imagem': imagem,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Documento &&
        other.titulo == titulo &&
        other.imagem == imagem;
  }

  @override
  int get hashCode => Object.hash(titulo, imagem);
}

class DocumentoException implements Exception {
  final String message;

  DocumentoException(this.message);

  @override
  String toString(){
    return message;
  }
}
