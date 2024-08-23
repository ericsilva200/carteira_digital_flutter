import 'dart:convert';

import 'dart:typed_data';
import 'dart:io';
import 'package:carteira/documento/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/domain.dart';


class EditPage extends ConsumerStatefulWidget {
  final Documento documento;

  const EditPage({super.key, required this.documento});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List webImage = Uint8List(8);
  File? selected;
  // ignore: unused_field
  File? _pickedImage;

  bool novaImagem = false;
  bool novoTitulo = false;
  bool textoValido = true;
  bool trocarTitulo = false;
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
              Text(
                widget.documento.titulo,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[400],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 240,
                child: novaImagem
                    ? Image.memory(webImage)
                    : Image.memory(base64Decode(widget.documento.imagem)),
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
                      novaImagem = true;
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
                      'Trocar Imagem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              !trocarTitulo
                  ? ElevatedButton(
                      child: Text('Editar Título'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[400],
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          trocarTitulo = true;
                          textoValido = false;
                        });
                      },
                    )
                  : SizedBox(),
              trocarTitulo
                  ? SizedBox(
                      width: 250,
                      height: 40,
                      child: TextField(
                        controller: tituloController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Digite o novo título do documento...',
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
                              novoTitulo = true;
                            } else {
                              textoValido = false;
                            }
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
                onPressed: (novaImagem && textoValido) || (novoTitulo && textoValido) 
                    ? () async {
                        bool result = await ref.read(documentoListControllerProvider.notifier).editDocumento(
                              widget.documento,
                              novoTitulo
                                    ? tituloController.text
                                    : widget.documento.titulo,
                                novaImagem
                                    ? base64Encode(webImage)
                                    : widget.documento.imagem,
                            );
                        if (!result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Documento não alterado, pois já existe outro com o mesmo nome.'),
                            ),
                          );
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
