import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_data.dart';
import '../Pages/home.page.dart';       
import '../Pages/list_content.dart';   
import '../Pages/preference.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 3 - About'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
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
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Lista'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ListContent()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context); // Ya estamos en esta pantalla
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
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          nameController.text = appData.userName;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Editar información del usuario', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nombre de usuario'),
                  onChanged: (value) {
                    appData.userName = value;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Permitir reiniciar contador'),
                    Switch(
                      value: appData.canResetCounter,
                      onChanged: (value) {
                        appData.canResetCounter = value;
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Text(
                  'Contador actual: ${appData.counter}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
