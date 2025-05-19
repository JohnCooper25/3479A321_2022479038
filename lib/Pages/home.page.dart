import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'list_content.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    print("createState: creando el estado de MyHomePage");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    logger.i("initState");
    print("mounted: $mounted");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i("didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i("didUpdateWidget");
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i("reassemble");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.w("deactivate");
  }

  @override
  void dispose() {
    logger.w("dispose");
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    logger.i("setState");
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build: reconstruyendo MyHomePage");

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
              SizedBox(
                width: 550,
                height: 450,
                child: Card(
                  margin: const EdgeInsets.all(20),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Página 1 - Home',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Bienvenido a la pagina principal.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ListContent()),
                            );
                          },
                          child: const Text('Ir a Pagina 2 (Lista)'),
                        ),
                      ],
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
