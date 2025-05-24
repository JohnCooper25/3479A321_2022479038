import 'package:application_laboratorio3/Pages/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/app_data.dart';
import 'activities_page.dart';
import 'list_content.dart';
import 'about.dart';

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

  _MyHomePageState() {
    print("Constructor de _MyHomePageState");
    print("mounted: $mounted");
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCanReset = prefs.getBool('canResetCounter') ?? true;
    final appData = Provider.of<AppData>(context, listen: false);
    appData.canResetCounter = savedCanReset;
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

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu de Navegacion',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Custom Themes')),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.room_preferences),
              title: const Text('Preferencias'),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PreferencesPage()),
                );
                _loadPreferences(); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Actividades'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActivitiesPage()),
                );
              },
            ),
          ],
        ),
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
                    child: Consumer<AppData>(
                      builder: (context, appData, child) {
                        return Column(
                          children: [
                            Text(
                              'Usuario: ${appData.userName}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Pagina 1 - Home',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                              onPressed: appData.canResetCounter
                                  ? () {
                                      appData.resetCounter();
                                    }
                                  : null,
                              child: const Text('Reiniciar contador'),
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
