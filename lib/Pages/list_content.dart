import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about.dart';
import '../provider/app_data.dart';
import '../Pages/home.page.dart'; 
import '../Pages/preference.dart';

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú de Navegación',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Lista'),
              onTap: () {
                Navigator.pop(context); // Ya estamos en esta página
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.room_preferences),
              title: const Text('Preferencias'),
              onTap: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const PreferencesPage()),
              );
            },
          ),
          ],
        ),
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
          Consumer<AppData>(
            builder: (context, appData, child) {
              return Text(
                'Contador: ${appData.counter}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
