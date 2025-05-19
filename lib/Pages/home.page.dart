import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
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
  int _counter = 0;

  
  _MyHomePageState() {
    print("Constructor de _MyHomePageState el mounted = $mounted");
  }

 
  @override
  void initState() {
    super.initState();
    print("initState llamado");
  }

 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies llamado");
  }

 
  @override
  Widget build(BuildContext context) {
    print("build llamado");
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


  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget llamado");
  }

  
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate llamado");
  }


  @override
  void dispose() {
    super.dispose();
    print("dispose llamado");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble llamado");
  }

  void _incrementCounter() {
    print("setState: incrementar");
    setState(() {
      _counter++;
    });
  }

  //  Decrementa el contador y actualiza la UI
  void _decrementCounter() {
    print("setState: decrementar");
    setState(() {
      _counter--;
    });
  }

  // Reinicia el contador y actualiza la UI
  void _resetCounter() {
    print("🔄 setState: resetear");
    setState(() {
      _counter = 0;
    });
  }

  // Barra inferior con los botones
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
}
