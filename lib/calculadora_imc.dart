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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
