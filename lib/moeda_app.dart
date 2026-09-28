// ignore_for_file: prefer_const_constructors, avoid_print

//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
