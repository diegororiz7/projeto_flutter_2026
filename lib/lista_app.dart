// ignore_for_file: file_names

import 'package:flutter/material.dart';

void main() {
  runApp(const ListaStateless());
}

class ListaStateless extends StatelessWidget {
  const ListaStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ListaStatefull(),
    );
  }
}

class ListaStatefull extends StatefulWidget {
  const ListaStatefull({super.key});

  @override
  State<ListaStatefull> createState() => _ListaStatefullState();
}

class _ListaStatefullState extends State<ListaStatefull> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
