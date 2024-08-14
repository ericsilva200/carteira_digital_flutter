import 'package:carteira/documento/providers/documentos_notifier.dart';
import 'package:carteira/documento/views/add_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaDocumentos = ref.watch(documentosNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carteira Digital',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[400],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 500,
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 80, right: 80),
                  child: listaDocumentos.isNotEmpty
                      ? ListView.separated(
                          itemCount: listaDocumentos.length,
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
                                      listaDocumentos[index].titulo,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewPage(
                                                documento:
                                                    listaDocumentos[index])),
                                      );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      // TextButton(
                                      //   onPressed: () {
                                      //     //
                                      //   },
                                      //   child: const Icon(Icons.edit, size: 20),
                                      // ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(documentosNotifierProvider.notifier)
                                              .removeDoc(listaDocumentos[index]);
                                        },
                                        child: const Icon(Icons.delete, size: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(child: const Text('Nenhum documento adicionado')),
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
                  onPressed: () {
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
