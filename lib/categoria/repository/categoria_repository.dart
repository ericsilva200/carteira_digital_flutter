import 'dart:convert';

import 'package:carteira/categoria/model/categoria_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'categoria_repository.g.dart';

class CategoriaPreferences {
  Future<List<Categoria>> findAll() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriasString = prefs.getStringList('categorias') ?? [];
    return categoriasString
        .map((json) => Categoria.fromJsonString(json))
        .toList();
  }

  Future<List<Categoria>> findAllByUserId(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriasString = prefs.getStringList('categorias') ?? [];
    return categoriasString
        .where((json) => Categoria.fromJsonString(json).userId == userId)
        .map((json) => Categoria.fromJsonString(json))
        .toList();
  }

  Future<List<Categoria>> findAllByName(name) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriasString = prefs.getStringList('categorias') ?? [];
    return categoriasString
        .where((json) => Categoria.fromJsonString(json).name == name)
        .map((json) => Categoria.fromJsonString(json))
        .toList();
  }

  Future<bool> save(Categoria categoria) async {
    final prefs = await SharedPreferences.getInstance();
    var catByName = await findAllByName(categoria.name);

    if (catByName.length == 0) {
      final categorias = await findAll();
      categorias.add(categoria);
      final categoriasString =
          categorias.map((c) => json.encode(c.toJson())).toList();
      await prefs.setStringList('categorias', categoriasString);
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final categorias = await findAll();
    final index = categorias.indexWhere((c) => c.id == id);
    if (index != -1) {
      categorias.removeAt(index);
      final categoriasString =
          categorias.map((c) => json.encode(c.toJson())).toList();
      await prefs.setStringList('categorias', categoriasString);
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<void> selectCategoria(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('categoria_selected', id);
  }

  Future<String?> getSelectedCategoria() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('categoria_selected');
  }
}

@Riverpod(keepAlive: true)
CategoriaPreferences categoriaPreferences(CategoriaPreferencesRef ref) {
  return CategoriaPreferences();
}
