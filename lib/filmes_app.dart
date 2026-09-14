// ignore_for_file: dead_code, unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaCategorias(),
        '/filmes': (context) => const TelaFilmes(),
        //'/detalhe': (context) => const TelaDetalheFilme(),
      },
    );
  }
}

class TelaCategorias extends StatelessWidget {
  const TelaCategorias({super.key});

  final List<String> categorias = const ['Ação', 'Comédia', 'Drama'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              index == 0
                  ? Icons.local_fire_department
                  : index == 1
                  ? Icons.theater_comedy
                  : Icons.sentiment_very_satisfied,
              color: Colors.indigo,
            ),
            title: Text(categorias[index]),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.indigo),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/filmes',
                arguments: categorias[index],
              );
            },
          );
        },
      ),
    );
  }
}

class TelaFilmes extends StatefulWidget {
  const TelaFilmes({super.key});

  @override
  State<TelaFilmes> createState() => _TelaFilmesState();
}

class _TelaFilmesState extends State<TelaFilmes> {
  final tituloController = TextEditingController();
  final generoController = TextEditingController();
  int nota = 3;

  final List<Map<String, dynamic>> filmes = [
    {'titulo': 'Mad Max', 'genero': 'Ação', 'nota': 5},
    {'titulo': 'John Wick', 'genero': 'Ação', 'nota': 5},
    {'titulo': 'Se beber não case', 'genero': 'Comédia', 'nota': 4},
    {'titulo': 'As branquelas', 'genero': 'Comédia', 'nota': 4},
    {'titulo': 'Clube da luta', 'genero': 'Drama', 'nota': 5},
    {'titulo': 'A procura da feclicidade', 'genero': 'Drama', 'nota': 5},
  ];

  void adicionarFilme() {
    if (tituloController.text.isEmpty || generoController.text.isEmpty) return;

    setState(() {
      filmes.add({
        'titulo': tituloController.text,
        'genero': generoController.text,
        'nota': nota,
      });
    });

    tituloController.clear();
    generoController.clear();
    nota = 3;
  }

  void removerFilme(int index) {
    setState(() {
      filmes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final genero = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    final filmesCategoria = filmes
        .where((filme) => filme['genero'] == genero)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes de $genero'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () {
          generoController.text = genero;

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Adicionar filme'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: tituloController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do filme',
                        prefixIcon: Icon(Icons.movie),
                      ),
                    ),
                    DropdownButton<int>(
                      value: nota,
                      items: [1, 2, 3, 4, 5]
                          .map(
                            (valor) => DropdownMenuItem(
                              value: valor,
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  Text('Nota $valor'),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (valor) {
                        setState(() {
                          nota = valor!;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      adicionarFilme();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                    label: Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }
}
