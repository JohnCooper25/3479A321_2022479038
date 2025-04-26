import 'package:flutter/material.dart';
import 'about.dart';

class ListContent extends StatelessWidget {
  const ListContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> elementos = [
      'Hola',
      'Como',
      'Estas',
      'Bienvenido',
      'Flutter',
      'Dart',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 2 - Lista'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: elementos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.list),
                  title: Text(elementos[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const About()),
                  );
                },
                child: const Text('Ir a Pagina 3 (About)'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Volver a Pagina 1 (Home)'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
