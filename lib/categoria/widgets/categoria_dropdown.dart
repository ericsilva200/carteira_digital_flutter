

import 'dart:developer';

import 'package:carteira/categoria/controller/categoria_controller.dart';
import 'package:carteira/categoria/model/categoria_model.dart';
import 'package:carteira/categoria/widgets/add_categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriaDropdown extends ConsumerStatefulWidget {
  const CategoriaDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoriaDropdownState();
}

class _CategoriaDropdownState extends ConsumerState<CategoriaDropdown> {
  String selectedValue = "all";

  Future<List<DropdownMenuItem<String>>> get dropdownItems async {
    List<Categoria> categorias = await ref.watch(categoriaControllerProvider.notifier).findAll();
    
    List<DropdownMenuItem<String>> menuItems = categorias.map((categ) => new DropdownMenuItem(child: Text(categ.name),value: categ.id)).toList();
    
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Categorias"),
        SizedBox(height: 8.0),
        Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(future: dropdownItems, builder: (context, snapshot) {
            return DropdownButton<String>(
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items:snapshot.data 
            );
          }),
          SizedBox(width: 12.0),
          AddCategoria()
      ],
    )
      ],
    );
  }


}