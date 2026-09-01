// ignore_for_file: use_super_parameters, unused_import, prefer_const_constructors, unused_local_variable

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
