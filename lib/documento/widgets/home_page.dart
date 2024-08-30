import 'package:carteira/categoria/widgets/categoria_dropdown.dart';
import 'package:carteira/documento/controller/controller.dart';
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

class DocumentoListWidget extends ConsumerWidget {
  const DocumentoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentoList = ref.watch(documentoListControllerProvider);
    return Column(
      children: [
        CategoriaDropdown(),
        documentoList.when(
      data: (l) => l.isEmpty
          ? const Center(
              child: Text('Nenhum documento cadastrado.'),
            )
          : ListView.separated(
              itemCount: l.length,
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
                          l[index].titulo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewPage(documento: l[index])),
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
                                    documento: l[index],
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
                                  .removeDocumento(l[index]);
                            },
                            child: const Icon(Icons.delete, size: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
      error: (o, s) => Text('Error: $o'),
      loading: () => const CircularProgressIndicator(),
    )
      ],
    );
  }
}
