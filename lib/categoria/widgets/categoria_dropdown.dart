import 'package:carteira/categoria/controller/categoria_controller.dart';
import 'package:carteira/categoria/model/categoria_model.dart';
import 'package:carteira/categoria/widgets/add_categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriaDropdown extends ConsumerStatefulWidget {
  const CategoriaDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriaDropdownState();
}

class _CategoriaDropdownState extends ConsumerState<CategoriaDropdown> {
  String selectedValue = "all";
  late List<Categoria> categorias;


  void updateCategoria() {
    ref.watch(categoriaControllerProvider.notifier).findAll().then((onValue) {
      setState(() {
        categorias = [...onValue];
      });
    });
  } 

  void updateSelectedCategoria() {
    ref.watch(categoriaControllerProvider.notifier).getSelectedCategoria().then((onValue) {
      setState(() {
        selectedValue = onValue!;
      });
    });
  }



  void _handleSelectCategoria(String categoriaId) {
    ref.read(categoriaControllerProvider.notifier).selectCategoria(categoriaId);
  }

  Future<List<DropdownMenuItem<String>>> get dropdownItems async {

    List<DropdownMenuItem<String>> menuItems = categorias
        .map((categ) =>
            new DropdownMenuItem(child: Text(categ.name), value: categ.id))
        .toList();

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {

    updateCategoria();
    updateSelectedCategoria();

    return Column(
      children: [
        Text("Categorias"),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: dropdownItems,
                builder: (context, snapshot) {
                  return DropdownButton<String>(
                      value: selectedValue,
                      onChanged: (newValue) {
                        _handleSelectCategoria(newValue!);
                      },
                      items: snapshot.data);
                }),
            SizedBox(width: 4.0),
            AddCategoria(reloadCategorias: (){})
          ],
        )
      ],
    );
  }
}
