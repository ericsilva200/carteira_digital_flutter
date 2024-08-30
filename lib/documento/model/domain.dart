import 'dart:convert';

class Documento {
  String? userId;
  String? categoriaId;
  String titulo;
  String imagem;

  Documento(this.userId, this.categoriaId, this.titulo, this.imagem);

  Documento copyWith({String? userId, String? categoriaId, String? titulo, String? imagem}) {
    return Documento(
      userId?? this.userId,
      categoriaId?? this.categoriaId,
      titulo ?? this.titulo,
      imagem ?? this.imagem,
    );
  }

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(json['userId'], json['categoriaId'], json['titulo'], json['imagem']);
  }

  static Documento fromJsonString(String jsonString) {
    return Documento.fromJson(json.decode(jsonString));
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'categoriaId': categoriaId,
      'titulo': titulo,
      'imagem': imagem,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Documento &&
        other.userId == userId &&
        other.categoriaId == categoriaId &&
        other.titulo == titulo &&
        other.imagem == imagem;
  }

  @override
  int get hashCode => Object.hash(userId,titulo, imagem);
}

class DocumentoException implements Exception {
  final String message;

  DocumentoException(this.message);

  @override
  String toString(){
    return message;
  }
}
