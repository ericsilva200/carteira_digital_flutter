import 'package:carteira/documento/model/domain.dart';
import 'package:carteira/usuario/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../service/service.dart';

part 'controller.g.dart';

@riverpod
class DocumentoListController extends _$DocumentoListController {
  @override
  Future<List<Documento>> build() async {
    return ref.read(documentoListServiceProvider).documentos;
  }

  Future<bool> addDocumento(String titulo, String imagem) async {
    state = const AsyncValue.loading();
    
    final userService = ref.read(userServiceProvider);
    var user = await userService.loggedUser;

    var documento = Documento(user.id, null, titulo, imagem);

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
