// ignore_for_file: unused_import, unused_field, prefer_final_fields

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: CalculadoraIMC(), debugShowCheckedModeBanner: false),
  );
}

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({super.key});

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  String _resultado = "Informe seus dados";

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
