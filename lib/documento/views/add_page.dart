import 'dart:convert';
import 'dart:typed_data';

import 'package:carteira/documento/providers/documentos_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../models/documento.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  late Uint8List imageFile;
  String? imageBase64;

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
                      child: Image.memory(imageFile),
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
                  final image = await ImagePickerWeb.getImageAsBytes();
                  imageBase64 = base64Encode(image!);
                  setState(() {
                    imageFile = image;
                    imageAvailable = true;
                  });
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
                    ? () {
                        ref.read(documentosNotifierProvider.notifier).addDoc(
                              Documento(
                                titulo: tituloController.text,
                                imagem: imageBase64!,
                              ),
                            );
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
