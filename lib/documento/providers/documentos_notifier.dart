import 'package:carteira/documento/models/documento.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'documentos_notifier.g.dart';

@riverpod
class DocumentosNotifier extends _$DocumentosNotifier {

  //initial value
  @override
  List<Documento> build() {
    return [
      
    ];
  }

  //methods to update state
  Future<void> addDoc(Documento documento) async {
    state = [...state, documento];
  }

  Future <void> removeDoc(Documento documento) async {
    state = state.where((element) => element != documento).toList();
  }

}


