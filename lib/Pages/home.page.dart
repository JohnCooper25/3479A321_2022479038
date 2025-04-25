import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';



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
    logger.i("Incremented count: $_counter");  
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
    // Agregar log aquí para cada vez que se construye el widget
    logger.i("Rebuilding MyHomePage");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'Assets/Icons/ICON_GAME.svg',
              semanticsLabel: 'Dart Logo',
            ),
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