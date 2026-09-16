// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

void main() {
  runApp(Receitas_Stateless());
}

class Receitas_Stateless extends StatelessWidget {
  const Receitas_Stateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Receitas',
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
      home: const Receitas_Statefull(),
    );
  }
}

class Receitas_Statefull extends StatefulWidget {
  const Receitas_Statefull({super.key});

  @override
  State<Receitas_Statefull> createState() => _Receitas_StatefullState();
}

class _Receitas_StatefullState extends State<Receitas_Statefull> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController tempoController = TextEditingController();

  final List<String> categorias = [
    'Brasileira',
    'Italiana',
    'Sobremesa',
    'Lanche',
    'Bebida',
    'Vegetariana',
  ];

  String categoriaSelecionada = 'Brasileira';

  List<Map<String, dynamic>> receitas = [];

  void adicionarReceita() {
    if (nomeController.text.isEmpty || tempoController.text.isEmpty) return;

    setState(() {
      receitas.add({
        'nome': nomeController.text,
        'tempo': tempoController.text,
        'categoria': categoriaSelecionada,
      });
      nomeController.clear();
      tempoController.clear();
      categoriaSelecionada = categorias.first;
    });
  }

  void removerReceita(int index) {
    setState(() {
      receitas.removeAt(index);
    });
  }

  IconData obterIcone(String categoria) {
    switch (categoria) {
      case 'Brasileira':
        return Icons.restaurant;

      case 'Italiana':
        return Icons.local_pizza;

      case 'Sobremesa':
        return Icons.cake;

      case 'Lanche':
        return Icons.lunch_dining;

      case 'Bebidas':
        return Icons.local_drink;

      case 'Vegetariana':
        return Icons.eco;

      default:
        return Icons.food_bank;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
