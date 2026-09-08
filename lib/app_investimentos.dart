// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors, unnecessary_import, implementation_imports, depend_on_referenced_packages, unused_import, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';

void main() => runApp(InvestimentosStateless());

class InvestimentosStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Primeiro App',
      theme: ThemeData(primaryColor: Colors.green),
      home: InvestimentosStatefull(),
    );
  }
}

class InvestimentosStatefull extends StatefulWidget {
  const InvestimentosStatefull({super.key});

  @override
  State<InvestimentosStatefull> createState() => _InvestimentosStatefullState();
}

class _InvestimentosStatefullState extends State<InvestimentosStatefull> {
  TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static final NumberFormat formatoReal = NumberFormat.currency(
    locale: 'pt-br',
  );

  double investimentoMensal = 0;
  double anosInvestindo = 0;
  double valorInvestido = 0;
  double resultado = 0;
  double rentabilidadeAnual = 0;
  double patrimonioAcumulado = 0;

  void atualizarValorInvestido() {
    setState(() {
      valorInvestido = investimentoMensal * (anosInvestindo * 12);
    });
  }

  void atualizarResultado() {
    setState(() {
      resultado =
          (investimentoMensal *
                  (pow(
                        1 + (rentabilidadeAnual / 12 / 100),
                        (anosInvestindo * 12),
                      ) -
                      1)) /
              (rentabilidadeAnual / 12 / 100) -
          rentabilidadeAnual;
    });
  }

  void atualizarPatrimonioAcumulado() {
    setState(() {
      patrimonioAcumulado = valorInvestido + resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
