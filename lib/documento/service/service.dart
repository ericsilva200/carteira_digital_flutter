import 'package:carteira/documento/repository/repository.dart';
import 'package:carteira/documento/model/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service.g.dart';

class DocumentoListService {
  final DocumentoPreferences documentoP;

  DocumentoListService({required this.documentoP});

  Future<List<Documento>> get documentos {
    return documentoP.findAllDocumentos();
  }

  Future<void> addDocumento(Documento documento) async {
    try {
      await documentoP.insertDocumento(documento);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeDocumento(Documento documento) async {
    documentoP.deleteDocumento(documento);
  }

  Future<void> editDocumento(Documento documento, String titulo, String imagem) async {
    final newDocumento = documento.copyWith(
        titulo: titulo, imagem: imagem);

    try {
      await documentoP.updateDocumento(documento, newDocumento);
    } catch (e){
      rethrow;
    }
    
  }
}

@Riverpod(keepAlive: true)
DocumentoListService documentoListService(DocumentoListServiceRef ref) {
  final prefs = ref.watch(documentoPreferencesProvider);
  return DocumentoListService(documentoP: prefs);
}
