

import 'dart:developer';

import 'package:carteira/categoria/controller/categoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class AddCategoria extends ConsumerWidget {
  final Function reloadCategorias;
  const AddCategoria({super.key, required this.reloadCategorias});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        _showCategoryModal(context, ref);
      },
      style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      ),
      child: const Icon(Icons.add),
    );
  }

  void _showCategoryModal(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _categoryController = TextEditingController();

        return AlertDialog(
          title: Text('Nova categoria'),
          content: TextField(
            controller: _categoryController,
            decoration: InputDecoration(
              labelText: 'Nome da categoria',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String categoryName = _categoryController.text;
                if (categoryName.isNotEmpty) {
                  
                  _createCategory(categoryName, ref);
                  Navigator.of(context).pop(); 
                }
              },
              child: Text('Criar'),
            ),
          ],
        );
      },
    );
  }

  void _createCategory(String categoria, ref) async {
    var created = await ref.read(categoriaControllerProvider.notifier).save(categoria);
  }

  
}