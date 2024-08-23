import 'dart:convert';

import 'package:carteira/documento/model/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'repository.g.dart';

class DocumentoPreferences {
  Future<List<Documento>> findAllDocumentos() async {
    final prefs = await SharedPreferences.getInstance();
    final documentosStringList = prefs.getStringList('documentos') ?? [];
    var documentosList =
        documentosStringList.map((e) => Documento.fromJsonString(e)).toList();

    return documentosList;
  }

  Future<void> insertDocumento(Documento documento) async {
    final documentosList = await findAllDocumentos();
    if (documentosList.any((d) => d.titulo == documento.titulo)) {
      throw DocumentoException('Esse documento já está cadastrado.');
    }
    final prefs = await SharedPreferences.getInstance();
    final documentosString = prefs.getStringList('documentos') ?? [];
    documentosString.add(json.encode(documento.toJson()));
    prefs.setStringList('documentos', documentosString);
  }

  Future<void> deleteDocumento(Documento documento) async {
    final prefs = await SharedPreferences.getInstance();
    final documentosString = prefs.getStringList('documentos') ?? [];
    documentosString
        .removeWhere((d) => Documento.fromJsonString(d) == documento);
    prefs.setStringList('documentos', documentosString);
  }

  Future<void> updateDocumento(Documento oldDocumento, Documento newDocumento) async {
    final documentosList = await findAllDocumentos();

    if(oldDocumento.titulo != newDocumento.titulo){
      if (documentosList.any((d) => d.titulo == newDocumento.titulo)) {
        throw DocumentoException('Esse documento já está cadastrado.');
      }
    }
    
    final prefs = await SharedPreferences.getInstance();
    final documentosString = prefs.getStringList('documentos') ?? [];
    final index = documentosString.indexWhere((d) => Documento.fromJsonString(d) == oldDocumento);
    if (index != -1) {
      documentosString[index] = json.encode(newDocumento.toJson());
      prefs.setStringList('documentos', documentosString);
    }
  }
}

@Riverpod(keepAlive: true)
DocumentoPreferences documentoPreferences(DocumentoPreferencesRef ref) {
  return DocumentoPreferences();
}
