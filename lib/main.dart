import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Proyect Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 239, 6, 41)),
      ),
      home: const MyHomePage(title: 'First Flutter Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  
  Widget _buildBottomButtons() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            IconButton(
              onPressed: _decrementCounter,
              icon: const Icon(Icons.remove, size: 30),
              tooltip: 'Decrementar',
            ),
            
            IconButton(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh, size: 30),
              tooltip: 'Reiniciar',
            ),
            
            IconButton(
              onPressed: _incrementCounter,
              icon: const Icon(Icons.add, size: 30),
              tooltip: 'Incrementar',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Has presionado el botón muchas veces:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: _buildBottomButtons(),
    );
  }
}
