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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
