

import 'dart:convert';

class Categoria {
  String? id;
  String? userId;
  String name;

  Categoria(this.id, this.userId, this.name);

  factory Categoria.fromJson(Map<String, dynamic> json) {
    
    return Categoria(json['id'], json['userId'], json['name']); 
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
    };
  }

  static Categoria fromJsonString(String json) {
    return Categoria.fromJson(jsonDecode(json));
  }



}