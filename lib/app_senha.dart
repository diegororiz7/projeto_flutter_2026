// ignore_for_file: use_super_parameters, unused_import, prefer_const_constructors, unused_local_variable, avoid_web_libraries_in_flutter, unnecessary_string_interpolations

import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const SenhaStateless());

class SenhaStateless extends StatelessWidget {
  const SenhaStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: SenhaStatefull(),
    );
  }
}

class SenhaStatefull extends StatefulWidget {
  const SenhaStatefull({super.key});

  @override
  State<SenhaStatefull> createState() => _SenhaStatefullState();
}

class _SenhaStatefullState extends State<SenhaStatefull> {
  double tamanho = 12;
  bool maius = true;
  bool minus = true;
  bool nums = true;
  bool simb = true;
  String senha = 'Informe sua senha';
  final random = Random();

  void gerarSenha() {
    String chars = '';
    if (maius) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (minus) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (nums) chars += '0123456789';
    if (simb) chars += '!@#%&*/';

    if (chars.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selecione ao menos uma opção!')));
    }

    String s = '';

    for (int i = 0; i < tamanho.round(); i++) {
      s += chars[random.nextInt(chars.length)];
    }

    setState(() {
      senha = s;
    });
  }

  String forcaSenha() {
    if (tamanho < 8) return 'Fraca';
    if (tamanho < 12) return 'Média';
    return 'Forte';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerador de senha'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tamanho: ${tamanho.round()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: tamanho,
                min: 4,
                max: 30,
                divisions: 26,
                label: tamanho.round().toString(),
                onChanged: (value) => setState(() {
                  tamanho = value;
                }),
              ),
              CheckboxListTile(
                value: maius,
                title: Text('Letras maiúsculas'),
                onChanged: (value) => setState(() {
                  maius = value!;
                }),
              ),
              CheckboxListTile(
                value: minus,
                title: Text('Letras minúscuas'),
                onChanged: (value) => setState(() {
                  minus = value!;
                }),
              ),
              CheckboxListTile(
                value: nums,
                title: Text('Números'),
                onChanged: (value) => setState(() {
                  nums = value!;
                }),
              ),
              CheckboxListTile(
                value: simb,
                title: Text('Símbolos'),
                onChanged: (value) => setState(() {
                  simb = value!;
                }),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: gerarSenha,
                  child: Text('Gerar senha'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/senha.jpg',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        Text('Senha gerada!', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 10),
                        SelectableText(
                          '$senha',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Força: ${forcaSenha()}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Icon(Icons.copy),
                            label: Text('Copar'),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: senha));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Senha copiada!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
