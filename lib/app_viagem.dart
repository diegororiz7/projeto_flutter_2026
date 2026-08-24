// ignore_for_file: unused_local_variable, unused_element, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> destinos = [
    '🏖️ Guarapari',
    '🌆 Rio de Janeiro',
    '🗽 Nova York',
    '🗼 Paris',
    '🏝️ Recife',
    '🌊 Maldivas',
    '🌈 Foz do Iguaçu',
    '🍷 Buenos Aires',
    '🚫 Sem viagem por enquanto 😢',
  ];

  String destinoAtual = '✈️ Próximo destino!';

  void gerarDestino() {
    final random = Random();
    setState(() {
      destinoAtual = destinos[random.nextInt(destinos.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sua próxima viagem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sua próxima viagem!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sua próxima viagem será: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  destinoAtual,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: gerarDestino,
                  child: Text(
                    '✈️ Gerar destino',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
