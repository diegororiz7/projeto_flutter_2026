// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, sort_child_properties_last, unnecessary_brace_in_string_interps

//import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ConversorMoeda()),
  );
}

class ConversorMoeda extends StatefulWidget {
  const ConversorMoeda({super.key});

  @override
  State<ConversorMoeda> createState() => _ConversorMoedaState();
}

class _ConversorMoedaState extends State<ConversorMoeda> {
  final TextEditingController controller = TextEditingController();

  String de = "USD";
  String para = "BRL";
  String? resultado;
  double? cotacao;
  bool carregando = false;

  final List<String> moedas = ["USD", "BRL", "EUR", "ARS", "CAD", "JPY", "BTC"];

  void inverterMoedas() {
    setState(() {
      final temp = de;
      de = para;
      para = temp;
      resultado = null;
      cotacao = null;
    });
  }

  Future<void> converterValor() async {
    final valor = controller.text;
    if (valor.isEmpty || double.tryParse(valor) == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Informe um valor válido')));
      return;
    }

    setState(() {
      carregando = true;
      cotacao = null;
      resultado = null;
    });

    try {
      final url = 'https://economia.awesomeapi.com.br/json/last/$de-$para';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final key = '$de$para';
        final taxa = double.parse(data[key]['bid']);

        final valorConvertido = double.parse(valor) * taxa;

        setState(() {
          cotacao = taxa;
          resultado = valorConvertido.toStringAsFixed(2);
        });
      } else {
        throw Exception('Erro na API');
      }
    } catch (e) {
      print('Erro na conversão $e');
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de moedas'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            buildDropdown('De: ', de, (val) {
              setState(() {
                de = val!;
              });
            }),
            SizedBox(height: 10),
            buildDropdown('Para: ', para, (val) {
              setState(() {
                para = val!;
              });
            }),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Inverter moedas'),
              onPressed: inverterMoedas,
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Digite o valor',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Converter valor'),
              onPressed: converterValor,
            ),
            if (carregando) ...[
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.blueAccent),
            ],
            if (resultado != null && cotacao != null) ...[
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Valor digitado: ${double.parse(controller.text).toStringAsFixed(2)} ${de}',
                      style: resultStyle,
                    ),
                    Text('Cotação: 1 $de = $cotacao $para', style: resultStyle),
                    Text(
                      'Valor convertido: ${resultado} ${para}',
                      style: resultStyle,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: SizedBox(),
              items: moedas
                  .map((m) => DropdownMenuItem(child: Text(m), value: m))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get resultStyle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.green.shade800,
  );
}
