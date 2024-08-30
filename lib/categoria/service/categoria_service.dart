

import 'package:carteira/categoria/model/categoria_model.dart';
import 'package:carteira/categoria/repository/categoria_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'categoria_service.g.dart';


class CategoriaService {
  final CategoriaPreferences categoriaPref;

  CategoriaService({required this.categoriaPref});

  Future<List<Categoria>> get categorias {
    return categoriaPref.findAll();
  }

  Future<List<Categoria>> findAllByUserId(String userId) {
    return categoriaPref.findAllByUserId(userId);
  }

  Future<bool> save(Categoria categoria) {

    if(categoria.id == null){
      var uuid = Uuid();
      categoria.id = uuid.v4();
    }
    return categoriaPref.save(categoria);
  }

  Future<bool> delete(String id) {
    return categoriaPref.delete(id);
  }

  

}

@Riverpod(keepAlive: true)
CategoriaService categoriaService(CategoriaServiceRef ref) {
  final prefs = ref.watch(categoriaPreferencesProvider);
  return CategoriaService(categoriaPref: prefs);
}