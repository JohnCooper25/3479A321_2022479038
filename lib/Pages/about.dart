import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_data.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 3 - About'),
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
         
          nameController.text = appData.userName;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Editar informacion del usuario', style: TextStyle(fontSize: 18)),
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

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Volver a Pagina 2 (Lista)'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
