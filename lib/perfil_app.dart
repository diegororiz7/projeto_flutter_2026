// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, unused_import, unused_local_variable, unused_catch_clause

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(PerfilStateless());

class PerfilStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplo Dio Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PerfilStatefull(),
    );
  }
}

class PerfilStatefull extends StatefulWidget {
  const PerfilStatefull({super.key});

  @override
  State<PerfilStatefull> createState() => _PerfilStatefullState();
}

class _PerfilStatefullState extends State<PerfilStatefull> {
  late Dio dio;
  int userId = 1;
  bool loading = false;

  String name = 'Nome';
  String email = 'Email';
  String avatar = 'https://picsum.photos/150/150';
  String job = '';

  TextEditingController jobController = TextEditingController();
  String result = '';

  @override
  void initState() {
    super.initState();
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'Content-Type': 'application/json'},
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
      ),
    );
  }

  Future<void> getUser() async {
    setState(() {
      loading = true;
    });

    try {
      Response response = await dio.get('/users/$userId');
      var data = response.data;

      setState(() {
        name = data['name'];
        email = data['email'];
        avatar = 'https://picsum.photos/150/150?img=$userId';
        job = '';
        result = '';
        userId++;
        if (userId > 10) userId = 1;
      });
    } on DioException catch (e) {
      result = e.response != null
          ? 'Erro ${e.response?.statusCode}: ${e.response?.data}'
          : 'Erro: ${e.message}';
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> sendUser() async {
    /*if (job.isEmpty) {
      setState(() {
        result = 'Informe uma profissão antes de enviar!';
        return;
      });
    }*/

    setState(() {
      loading = true;
    });

    try {
      Response response = await dio.post(
        '/posts',
        data: jsonEncode({'name': name, 'job': jobController.text}),
      );

      result =
          'Usuário enviado com sucesso!\nId gerado: ${response.data['id']}\nNome: ${response.data['name']}\n Profissão: ${response.data['job']}';
      job = jobController.text;
      jobController.clear();
    } on DioException catch (e) {
      result = e.response != null
          ? 'Erro ${e.response?.statusCode}: ${e.response?.data}'
          : 'Erro: ${e.message}';
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar perfil'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 60, backgroundImage: NetworkImage(avatar)),
            SizedBox(height: 6),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 6),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            if (job.isNotEmpty) ...[
              SizedBox(height: 6),
              Text(
                'Profissão: $job',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
              ),
            ],
            SizedBox(height: 20),
            TextField(
              controller: jobController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Digite sua profissão',
                prefixIcon: Icon(Icons.work_outline),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    onPressed: getUser,
                    label: Text('Obter perfil'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    onPressed: sendUser,
                    label: Text('Enviar usuário'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (loading) CircularProgressIndicator(),
            if (result.isNotEmpty && !loading && job.isNotEmpty)
              Card(
                color: Colors.green.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(result, style: TextStyle(fontSize: 16)),
                ),
              ),
            if (result.isNotEmpty && !loading && job.isEmpty)
              Card(
                color: Colors.green.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Informe uma profissão antes de enviar!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
