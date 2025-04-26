import 'package:flutter/material.dart';

class ListContent extends StatelessWidget {
  const ListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contenidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pantalla para seccion de listas.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Boton 1 presionado')),
                );
              },
              child: const Text('Boton 1'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Boton 2 presionado')),
                );
              },
              child: const Text('Boton 2'),
            ),
          ],
        ),
      ),
    );
  }
}
