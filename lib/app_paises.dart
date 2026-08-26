// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

void main() {
  runApp(Paises_Stateless());
}

class Pais {
  final String nome;
  final String capital;
  final String localizacao;
  final String imagem;
  bool curtido;

  Pais({
    required this.nome,
    required this.capital,
    required this.localizacao,
    required this.imagem,
    this.curtido = false,
  });
}

class Paises_Stateless extends StatelessWidget {
  const Paises_Stateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Países',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Paises_Stateful(),
    );
  }
}

class Paises_Stateful extends StatefulWidget {
  const Paises_Stateful({super.key});

  @override
  State<Paises_Stateful> createState() => _Paises_StatefulState();
}

class _Paises_StatefulState extends State<Paises_Stateful> {
  final List<Pais> paises = [
    Pais(
      nome: 'Brasil',
      capital: 'Brasília',
      localizacao: 'América do Sul',
      imagem: 'https://flagcdn.com/w320/br.png',
    ),
    Pais(
      nome: 'Japão',
      capital: 'Tóquio',
      localizacao: 'Ásia',
      imagem: 'https://flagcdn.com/w320/jp.png',
    ),
    Pais(
      nome: 'Etiópia',
      capital: 'Adis Abeba',
      localizacao: 'África',
      imagem: 'https://flagcdn.com/w320/et.png',
    ),
  ];

  void curtirPais(int index) {
    setState(() {
      paises[index].curtido = !paises[index].curtido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Países'), centerTitle: true),
      body: ListView.builder(
        itemCount: paises.length,
        itemBuilder: (context, index) {
          //final pais = paises[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListTile(
              leading: Image.network(
                paises[index].imagem,
                fit: BoxFit.cover,
                width: 50,
                height: 40,
              ),
              title: Text(
                paises[index].nome,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paises[index].capital),
                  Text(paises[index].localizacao),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  paises[index].curtido
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                color: paises[index].curtido ? Colors.red : null,
                onPressed: () => curtirPais(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
