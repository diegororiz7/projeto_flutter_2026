// ignore_for_file: unused_import, unused_field, prefer_final_fields, unused_local_variable, unused_element, sort_child_properties_last

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

  void limparCampos() {
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _resultado = 'Informe seus dados';
    });
  }

  void calcularImc() {
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);
    String classificacao;
    final imc = peso! / pow(altura!, 2);

    if (imc < 18.5) {
      classificacao = 'Baixo peso';
    } else if (imc < 25) {
      classificacao = 'Peso normal';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else {
      classificacao = 'Obesidade';
    }

    setState(() {
      _resultado =
          'IMC = ${imc.toStringAsFixed(1)}\nClassificação: $classificacao';
    });
  }

  Widget _buildTextoCampo({
    required TextEditingController controller,
    required String label,
    required String error,
    required double max,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (text) {
        final value = double.tryParse(text ?? '');
        if (value == null || value <= 0 || value > max) {
          return 'Informe um valor válido';
        }
        return null;
      },
    );
  }

  Widget _buildResultado() {
    return Text(
      _resultado,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: limparCampos, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextoCampo(
                controller: _pesoController,
                label: 'Peso (kg)',
                error: 'Informe um peso válido (entre 1 e 300 kg)',
                max: 300,
              ),
              SizedBox(height: 10),
              _buildTextoCampo(
                controller: _alturaController,
                label: 'Altura (m)',
                error: 'Informe um altura válida (entre 0.1 e 2.5 m)',
                max: 2.5,
              ),
              const SizedBox(height: 30),
              _buildResultado(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calcularImc();
                  }
                },
                child: const Text(
                  'CALCULAR',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
