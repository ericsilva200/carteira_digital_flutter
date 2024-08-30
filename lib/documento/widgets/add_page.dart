import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carteira/documento/controller/controller.dart';
import 'package:carteira/documento/model/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List webImage = Uint8List(8);
  File? selected;
  // ignore: unused_field
  File? _pickedImage;
  bool imageAvailable = false;
  bool textoValido = false;
  final tituloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira Digital'),
        backgroundColor: Colors.deepPurple[400],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageAvailable
                  ? SizedBox(
                      width: 500,
                      height: 300,
                      child: Image.memory(webImage),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                  controller: tituloController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Digite o título do documento...',
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  onChanged: (tituloController) => setState(
                    () {
                      if (tituloController.length >= 2) {
                        textoValido = true;
                      } else {
                        textoValido = false;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  XFile? img =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (img != null) {
                    var f = await img.readAsBytes();
                    setState(() {
                      webImage = f;
                      _pickedImage = File('a');
                      imageAvailable = true;
                    });
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.deepPurple[400],
                    ),
                    child: const Text(
                      'Selecionar Imagem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
                onPressed: imageAvailable && textoValido
                    ? () async {
                        bool result = await ref
                            .read(documentoListControllerProvider.notifier)
                            .addDocumento(
                                tituloController.text, base64Encode(webImage));
                        if (context.mounted) {
                          if (!result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Documento não adicionado, pois já existe outro com o mesmo nome.'),
                              ),
                            );
                          }
                        }
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
