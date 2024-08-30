

import 'package:carteira/categoria/model/categoria_model.dart';
import 'package:carteira/categoria/service/categoria_service.dart';
import 'package:carteira/usuario/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categoria_controller.g.dart';

@riverpod
class CategoriaController extends _$CategoriaController {
  
  @override
  Future<List<Categoria>> build() async {
    ref.read(categoriaServiceProvider).save(Categoria("all", "", "Todos os documentos"));
    return ref.read(categoriaServiceProvider).categorias;
  }

  Future<List<Categoria>> findAll() async {
    return ref.read(categoriaServiceProvider).categorias;
  }

  Future<bool> save(name) async {
    var loggedUser = await ref.read(userServiceProvider).loggedUser;
    return await ref.read(categoriaServiceProvider).save(Categoria(null, loggedUser.id, name));
  }
  
}