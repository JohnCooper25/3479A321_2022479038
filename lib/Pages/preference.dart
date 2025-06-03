import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/app_data.dart';
import 'home.page.dart';   
import 'list_content.dart';
import 'about.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  late bool _canReset;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCanReset = prefs.getBool('canResetCounter') ?? true;
    setState(() {
      _canReset = savedCanReset;
    });

    final appData = Provider.of<AppData>(context, listen: false);
    appData.canResetCounter = savedCanReset;
  }

  void _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('canResetCounter', _canReset);
  }

  @override
  void dispose() {
    _savePreferences();
    super.dispose();
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.purple),
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
            title: const Text('Preferencias'),
            onTap: () {
              Navigator.pop(context);  
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferencias"),
      ),
      drawer: _buildDrawer(context),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'Permitir reiniciar contador',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _canReset,
                  onChanged: (value) {
                    setState(() {
                      _canReset = value;
                    });
                    appData.canResetCounter = value;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
