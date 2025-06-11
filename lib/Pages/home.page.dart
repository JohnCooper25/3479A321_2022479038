import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';

import '../provider/app_data.dart';
import 'list_content.dart';
import 'picture_screen.dart';

List<CameraDescription> cameras = [];
late CameraDescription firstCamera;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final logger = Logger();
  String _imageUrl = 'https://picsum.photos/250?image=28';
  String? _imagePath;

  _MyHomePageState() {
    print("Constructor de _MyHomePageState");
    print("mounted: $mounted");
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadCameras();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCanReset = prefs.getBool('canResetCounter') ?? true;
    final appData = Provider.of<AppData>(context, listen: false);
    appData.canResetCounter = savedCanReset;
  }

  Future<void> _loadCameras() async {
    cameras = await availableCameras();
    setState(() {
      firstCamera = cameras.first;
    });
  }

  Future<void> _getNewImage() async {
    final counter = context.read<AppData>().counter;
    final newImageUrl = 'https://picsum.photos/250?image=${28 + counter}';

    try {
      final response = await http.head(Uri.parse(newImageUrl));
      if (response.statusCode == 200) {
        setState(() {
          _imageUrl = newImageUrl;
          _imagePath = null; // reset path if loading from web
        });
      } else {
        setState(() {
          _imageUrl = '';
        });
      }
    } catch (e) {
      setState(() {
        _imageUrl = '';
      });
    }
  }

  Future<void> _navigateToCamera() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => PictureScreen(camera: firstCamera),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _imagePath = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    final counterValue = context.watch<AppData>().counter;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'Assets/Icons/ICON_GAME.svg',
                semanticsLabel: 'Dart Logo',
              ),
              const SizedBox(height: 20),
              _imagePath != null
                  ? Image.file(
                      File(_imagePath!),
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      _imageUrl.isNotEmpty ? _imageUrl : '',
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'Failed to load image',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _getNewImage,
                child: const Text('Actualizar imagen'),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 550,
                ),
                child: Card(
                  margin: const EdgeInsets.all(20),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<AppData>(
                      builder: (context, appData, child) {
                        return Column(
                          children: [
                            Text(
                              'Usuario: ${appData.userName}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Pagina 1 - Home',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Bienvenido a la pagina principal.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Contador: ${appData.counter}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    appData.incrementCounter();
                                  },
                                  child: const Text('Subir'),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: appData.canResetCounter
                                      ? () {
                                          appData.decrementCounter();
                                        }
                                      : null,
                                  child: const Text('Bajar'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ListContent()),
                                );
                              },
                              child: const Text('Ir a Pagina 2 (Lista)'),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: appData.canResetCounter
                                  ? () {
                                      appData.resetCounter();
                                    }
                                  : null,
                              child: const Text('Reiniciar contador'),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _navigateToCamera,
                              child: const Text('Ir a cámara'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
