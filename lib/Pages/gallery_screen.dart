import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<FileSystemEntity> imageFiles = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final images = directory.listSync().where((file) {
      return file.path.endsWith('.jpg') || file.path.endsWith('.png');
    }).toList();

    setState(() {
      imageFiles = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Galeria de imagenes")),
      body: imageFiles.isEmpty
          ? const Center(child: Text("No hay imagenes guardadas"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: imageFiles.length,
              itemBuilder: (context, index) {
                return Image.file(File(imageFiles[index].path), fit: BoxFit.cover);
              },
            ),
    );
  }
}
