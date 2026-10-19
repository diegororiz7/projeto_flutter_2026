// ignore_for_file: non_constant_identifier_names, unused_local_variable, deprecated_member_use, unnecessary_string_interpolations

import 'package:flutter/material.dart';

void main() {
  runApp(const AcademiaStateless());
}

class Exercicio {
  String nome;
  String grupo;
  int series;
  int repeticoes;
  double carga;
  int descanso;
  bool concluido;

  Exercicio({
    required this.nome,
    required this.grupo,
    required this.series,
    required this.repeticoes,
    required this.carga,
    required this.descanso,
    this.concluido = false,
  });
}

class AcademiaStateless extends StatelessWidget {
  const AcademiaStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ficha de Academia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const AcademiaStatefull(),
    );
  }
}

class AcademiaStatefull extends StatefulWidget {
  const AcademiaStatefull({super.key});

  @override
  State<AcademiaStatefull> createState() => _AcademiaStatefullState();
}

class _AcademiaStatefullState extends State<AcademiaStatefull> {
  List<Exercicio> exercicios = [];
  List<Exercicio> filtrados = [];

  final TextEditingController searchController = TextEditingController();

  final grupos = [
    'Peito',
    'Costas',
    'Pernas',
    'Ombros',
    'Bíceps',
    'Tríceps',
    'Abdômen',
    'Cardio',
  ];

  @override
  void initState() {
    super.initState();
    filtrados = exercicios;
  }

  void atualizarBusca(String value) {
    setState(() {
      filtrados = exercicios
          .where(
            (e) =>
                e.nome.toLowerCase().contains(value.toLowerCase()) ||
                e.grupo.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  double get cargaTotal {
    double total = 0;
    for (var e in exercicios) {
      total += e.carga * e.series;
    }
    return total;
  }

  int get concluidos => exercicios.where((e) => e.concluido).length;

  void adicionarEditar({Exercicio? exercicio, int? index}) {
    final nomeController = TextEditingController(text: exercicio?.nome ?? '');
    final seriesController = TextEditingController(
      text: exercicio?.series.toString() ?? '',
    );
    final repeticoesController = TextEditingController(
      text: exercicio?.repeticoes.toString() ?? '',
    );
    final cargaController = TextEditingController(
      text: exercicio?.carga.toString() ?? '',
    );
    final descansoController = TextEditingController(
      text: exercicio?.descanso.toString() ?? '',
    );
    String grupoSelecionado = exercicio?.grupo ?? grupos.first;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            exercicio == null ? 'Adicionar exercício' : 'Editar exercício',
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                DropdownButtonFormField(
                  value: grupoSelecionado,
                  items: grupos
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      grupoSelecionado = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Grupo muscular',
                  ),
                ),
                TextField(
                  controller: seriesController,
                  decoration: const InputDecoration(labelText: 'Séries'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: repeticoesController,
                  decoration: const InputDecoration(labelText: 'Repetições'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: cargaController,
                  decoration: const InputDecoration(labelText: 'Carga (kg)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descansoController,
                  decoration: const InputDecoration(labelText: 'Descanso (s)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final novo = Exercicio(
                  nome: nomeController.text,
                  grupo: grupoSelecionado,
                  series: int.tryParse(seriesController.text) ?? 0,
                  repeticoes: int.tryParse(repeticoesController.text) ?? 0,
                  carga: double.tryParse(cargaController.text) ?? 0,
                  descanso: int.tryParse(descansoController.text) ?? 0,
                );

                setState(() {
                  if (exercicio == novo) {
                    exercicios.add(novo);
                  } else {
                    exercicios[index!] = novo;
                  }
                  filtrados = exercicios;
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void excluir(int index) {
    setState(() {
      exercicios.removeAt(index);
      filtrados = exercicios;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Exercício excluído!')));
  }

  Widget cardExercicio(Exercicio e, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🏋️ ${e.nome}'),
            Checkbox(
              value: e.concluido,
              onChanged: (value) {
                setState(() {
                  e.concluido = value!;
                });
              },
            ),
            Text('${e.series} séries'),
            Text('${e.repeticoes} repetições'),
            Text('${e.carga} (kg)'),
            Text('${e.descanso} (s)'),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () => adicionarEditar(exercicio: e, index: index),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => excluir(index),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget estatisticas() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [Text('Exercícios'), Text('${exercicios.length}')],
            ),
            Column(children: [Text('Concluídos'), Text('$concluidos')]),
            Column(
              children: [
                Text('Carga Total'),
                Text('${cargaTotal.toStringAsFixed(1)} kg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
