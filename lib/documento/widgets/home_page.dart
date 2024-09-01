import 'dart:developer';

import 'package:carteira/categoria/controller/categoria_controller.dart';
import 'package:carteira/categoria/widgets/categoria_dropdown.dart';
import 'package:carteira/documento/controller/controller.dart';
import 'package:carteira/documento/model/domain.dart';
import 'package:carteira/documento/widgets/add_page.dart';
import 'package:carteira/documento/widgets/edit_page.dart';
import 'package:carteira/documento/widgets/view_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'Carteira Digital',
      ),
      backgroundColor: Colors.deepPurple[400],
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 500,
          margin: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: DocumentoListWidget(),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[400],
                      foregroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25)),
                  onPressed: () async {
                    ref.read(categoriaControllerProvider.notifier).resetCategoriaSelected();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddPage()),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentoListWidget extends ConsumerStatefulWidget {
  const DocumentoListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentoListWidgetState();
}

class _DocumentoListWidgetState extends ConsumerState<DocumentoListWidget> {

  String categoriaSelected = "all";

   fetchCategoriaSelected() {
     ref.watch(categoriaControllerProvider.notifier).getSelectedCategoria().then((newValue) {
      log(newValue!);
      if(categoriaSelected != newValue) {
        log(newValue!);
        setState(() {
         categoriaSelected = newValue!;
        });
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchCategoriaSelected();
    var documentoList = ref.watch(documentoListControllerProvider.notifier).getFilteredDocumentos(categoriaSelected);

   return Column(
    children: [
      CategoriaDropdown(),
      FutureBuilder<List<Documento>>(
        future: documentoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData ||snapshot.data!.isEmpty) {
            
            return const Center(
              child: Text('Nenhum documento cadastrado.'),
            );
          } else if (snapshot.hasData) {
            
            final documentos = snapshot.data!;
            return ListView.separated(
              itemCount: documentos.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          documentos[index].titulo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewPage(documento: documentos[index])),
                          );
                        },
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPage(
                                    documento: documentos[index],
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.edit, size: 20),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(
                                      documentoListControllerProvider.notifier)
                                  .removeDocumento(documentos[index]);
                            },
                            child: const Icon(Icons.delete, size: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            
            return const SizedBox.shrink();
          }
        },
      ),
    ],
  );
  }
}
