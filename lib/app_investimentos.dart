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
  double rentabilidadeAnual = 1;
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
          valorInvestido;
    });
  }

  void atualizarPatrimonioAcumulado() {
    setState(() {
      patrimonioAcumulado = valorInvestido + resultado;
    });
  }

  Widget textoTitulo() {
    return Text(
      'Calculadora de Investimentos',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget imagemCalculadora() {
    return SizedBox(
      height: 50,
      child: Image.asset(
        'assets/images/rentabilidade.jpg',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget cardInvestimento() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Investimento mensal', style: textStyle),
                  Spacer(),
                  Text(
                    '${formatoReal.format(investimentoMensal)}',
                    style: textStyle,
                  ),
                ],
              ),
            ),
            Slider(
              value: investimentoMensal,
              min: 0,
              max: 10000,
              divisions: 1000,
              activeColor: Colors.green.shade900,
              inactiveColor: Colors.green.shade100,
              onChanged: (double value) {
                setState(() {
                  investimentoMensal = value;
                });
                atualizarValorInvestido();
                atualizarResultado();
                atualizarPatrimonioAcumulado();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardTempo() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Tempo investimento (anos)', style: textStyle),
                  Spacer(),
                  Text(anosInvestindo.toString() + ' anos', style: textStyle),
                ],
              ),
            ),
            Slider(
              value: anosInvestindo,
              min: 0,
              max: 20,
              divisions: 20,
              activeColor: Colors.green.shade900,
              inactiveColor: Colors.green.shade100,
              onChanged: (double value) {
                setState(() {
                  anosInvestindo = value;
                });
                atualizarValorInvestido();
                atualizarResultado();
                atualizarPatrimonioAcumulado();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRentabilidade() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Rentabilidade anual', style: textStyle),
                  Spacer(),
                  Text(rentabilidadeAnual.toString() + '%', style: textStyle),
                ],
              ),
            ),
            Slider(
              value: rentabilidadeAnual,
              min: 1,
              max: 20,
              divisions: 4,
              activeColor: Colors.green.shade900,
              inactiveColor: Colors.green.shade100,
              onChanged: (double value) {
                setState(() {
                  rentabilidadeAnual = value;
                });
                atualizarValorInvestido();
                atualizarResultado();
                atualizarPatrimonioAcumulado();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardResultado() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 30),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Valor investido: ', style: textStyle),
                Text('${formatoReal.format(valorInvestido)}', style: textStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Resultado: ', style: textStyle),
                Text('${formatoReal.format(resultado)}', style: textStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Patrimônio acumulado: ', style: textStyle),
                Text(
                  '${formatoReal.format(patrimonioAcumulado)}',
                  style: textStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            textoTitulo(),
            imagemCalculadora(),
            SizedBox(height: 20),
            cardInvestimento(),
            cardTempo(),
            cardRentabilidade(),
            cardResultado(),
          ],
        ),
      ),
    );
  }
}
