// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors

//import 'dart:convert';
//import 'package:dio/dio.dart';
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
  //late Dio dio;
  int userId = 1;
  bool loading = false;

  String name = 'Nome';
  String email = 'Email';
  String avatar = 'https://via.placeholder.com/150';
  String job = '';

  TextEditingController jobController = TextEditingController();
  String result = '';

  /*void initState() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'Content-Type': 'application/json'},
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5)));
  }*/

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
