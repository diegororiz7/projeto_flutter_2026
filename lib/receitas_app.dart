// ignore_for_file: camel_case_types, sort_child_properties_last, unused_local_variable, deprecated_member_use

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
      categoriaSelecionada = 'Brasileira';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de receitas'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da receita',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: tempoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tempo da receita (minutos)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
              ),
              value: categoriaSelecionada,
              items: categorias.map((categoria) {
                return DropdownMenuItem(
                  value: categoria,
                  child: Text(categoria),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  categoriaSelecionada = valor!;
                });
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: Text('Adicionar receita'),
                onPressed: adicionarReceita,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: receitas.isEmpty
                  ? const Center(
                      child: Text(
                        'Não existem receitas cadastradas',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: receitas.length,
                      itemBuilder: (context, index) {
                        final receita = receitas[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Icon(
                              obterIcone(receita['nome']),
                              size: 40,
                              color: Colors.orange,
                            ),
                            title: Text(
                              receita['nome'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Categoria: ${receita['categoria']}'),
                                Text('Tempo (minutos): ${receita['tempo']}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                removerReceita(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
