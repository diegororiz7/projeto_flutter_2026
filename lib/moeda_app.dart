// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ConversorMoeda()),
  );
}

class ConversorMoeda extends StatefulWidget {
  @override
  _ConversorMoedaState createState() => _ConversorMoedaState();
}

class _ConversorMoedaState extends State<ConversorMoeda> {
  final TextEditingController _controller = TextEditingController();

  String de = "USD";
  String para = "BRL";
  String? resultado;
  double? cotacao;
  bool carregando = false;

  final List<String> moedas = ["USD", "BRL", "EUR", "ARS", "CAD", "JPY", "BTC"];

  Future<void> converter() async {
    final valor = _controller.text;
    if (valor.isEmpty || double.tryParse(valor) == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Digite um valor válido")));
      return;
    }

    setState(() {
      carregando = true;
      resultado = null;
      cotacao = null;
    });

    try {
      final url = "https://economia.awesomeapi.com.br/json/last/$de-$para";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final key = "$de$para";
        final taxa = double.parse(data[key]["bid"]);

        final valorConvertido = double.parse(valor) * taxa;

        setState(() {
          cotacao = taxa;
          resultado = valorConvertido.toStringAsFixed(2);
        });
      } else {
        throw Exception("Erro na API");
      }
    } catch (e) {
      print("Erro na conversão: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao buscar cotação. Tente novamente.")),
      );
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  void inverterMoedas() {
    setState(() {
      final temp = de;
      de = para;
      para = temp;
      resultado = null;
      cotacao = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f4f7),
      appBar: AppBar(
        title: Text("💸 Conversor de Moedas"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              buildDropdown("De:", de, (val) {
                setState(() => de = val!);
              }),
              buildDropdown("Para:", para, (val) {
                setState(() => para = val!);
              }),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: inverterMoedas,
                child: Text("🔄 Inverter moedas"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Valor a converter",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: converter, child: Text("Converter")),
              if (carregando) ...[
                SizedBox(height: 20),
                CircularProgressIndicator(color: Colors.blueAccent),
              ],
              if (resultado != null && cotacao != null) ...[
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xffe8f5e9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "💸 Valor digitado: ${_controller.text} $de",
                        style: resultStyle,
                      ),
                      Text(
                        "📈 Cotação: 1 $de = ${cotacao!.toStringAsFixed(4)} $para",
                        style: resultStyle,
                      ),
                      Text(
                        "💰 Valor convertido: $resultado $para",
                        style: resultStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
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
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
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
