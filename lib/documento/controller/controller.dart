import 'dart:developer';

import 'package:carteira/categoria/service/categoria_service.dart';
import 'package:carteira/documento/model/domain.dart';
import 'package:carteira/usuario/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../service/service.dart';

part 'controller.g.dart';

@riverpod
class DocumentoListController extends _$DocumentoListController {
  @override
  Future<List<Documento>> build() async {
    final categoriaSelecionada = await ref.watch(categoriaServiceProvider).getSelectedCategoria();
    final documentos = await ref.watch(documentoListServiceProvider).documentos;

    return documentos.where((doc) => doc.categoriaId == categoriaSelecionada).toList();
  }

  Future<List<Documento>> getFilteredDocumentos(String categoriaId) async {

    var documentos = await ref.watch(documentoListServiceProvider).documentos;
    var dto = documentos.where((doc) => doc.categoriaId == categoriaId).toList();
    
    return dto;
  }

  Future<bool> addDocumento(String titulo, String imagem) async {
    state = const AsyncValue.loading();
    
    final userService = ref.read(userServiceProvider);
    final categoriaService = ref.read(categoriaServiceProvider);
    
    var categoriaSelected = await categoriaService.getSelectedCategoria();
    var user = await userService.loggedUser;

    var documento = Documento(user.id, categoriaSelected, titulo, imagem);

    final documentoService = ref.read(documentoListServiceProvider);
    try {
      await documentoService.addDocumento(documento);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    } finally {
      state = AsyncValue.data(await documentoService.documentos);
    }
  }

  Future<void> removeDocumento(Documento documento) async {
    state = const AsyncValue.loading();

    final documentoService = ref.read(documentoListServiceProvider);

    try {
      await documentoService.removeDocumento(documento);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return;
    }

    state = AsyncValue.data(await documentoService.documentos);
  }

  Future<bool> editDocumento(
      Documento documento, String titulo, String imagem) async {
        
    state = const AsyncValue.loading();
    final provider = ref.read(documentoListServiceProvider);

    try {
      await provider.editDocumento(documento, titulo, imagem);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    } finally {
      state = AsyncValue.data(await provider.documentos);
    }
  }
}
