import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/documento.dart';

class ViewPage extends ConsumerWidget {
  final Documento documento;

  const ViewPage({super.key, required this.documento});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira Digital'),
        backgroundColor: Colors.deepPurple[400],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                child: Image.memory(base64Decode(documento.imagem)),
                constraints: const BoxConstraints(
                  maxHeight: 450,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                documento.titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
