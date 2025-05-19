import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'provider/app_data.dart';
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

  _MyHomePageState() {
    print("Constructor de _MyHomePageState");
    print("mounted: $mounted");
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    final counterValue = context.watch<AppData>().counter;  // Obtiene el contador desde Provider

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
                          'Pagina 1 - Home',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Contador: $counterValue',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            // En vez de setState, incrementa el contador desde Provider
                            context.read<AppData>().incrementCounter();
                          },
                          child: const Text('Incrementar contador'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Decrementar contador
                            context.read<AppData>().decrementCounter();
                          },
                          child: const Text('Decrementar contador'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Resetear contador
                            context.read<AppData>().resetCounter();
                          },
                          child: const Text('Resetear contador'),
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
