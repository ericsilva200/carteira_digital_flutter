import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/documento.dart';

part 'documentos_provider.g.dart';

List<Documento> todosDocumentos = [

];

@riverpod
List<Documento> documentos(ref) {
  return todosDocumentos;
}
