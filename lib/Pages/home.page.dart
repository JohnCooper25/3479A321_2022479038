import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'list_content.dart';
import 'about.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final logger = Logger();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    logger.i("Incremented counter: $_counter");
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    logger.i("Decremented counter: $_counter");
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    logger.i("Counter reset");
  }

  @override
  Widget build(BuildContext context) {
    logger.i("Rebuilding MyHomePage");

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

              // Card con todo el contenido
              SizedBox(
                width: 550,
                height: 400,
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
                        Row(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.blue),
                            SizedBox(width: 40),
                            Text(
                              'Acerca de Flutter',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Flutter es un framework UI de código abierto creado por Google para construir interfaces nativas eficientemente.',
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),

                        // Contador
                        const Text('Has presionado el botón muchas veces:'),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 20),

                        // Botones dentro de la Card
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: _decrementCounter,
                              icon: const Icon(Icons.remove_circle, size: 35, color: Colors.red),
                              tooltip: 'Decrementar',
                            ),
                            IconButton(
                              onPressed: _resetCounter,
                              icon: const Icon(Icons.refresh, size: 35, color: Colors.orange),
                              tooltip: 'Reiniciar',
                            ),
                            IconButton(
                              onPressed: _incrementCounter,
                              icon: const Icon(Icons.add_circle, size: 35, color: Colors.green),
                              tooltip: 'Incrementar',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botones para las nuevas pantallas
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListContent()),
                  );
                },
                child: const Text('Ir a Lista de Contenido'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const About()),
                  );
                },
                child: const Text('Ir a Sobre'),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
