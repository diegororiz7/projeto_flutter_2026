import 'package:flutter/material.dart';

void main() {
  runApp(ContagemStateless());
}

class ContagemStateless extends StatelessWidget {
  const ContagemStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Contagem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      home: ContagemStatefull(),
    );
  }
}

class ContagemStatefull extends StatefulWidget {
  const ContagemStatefull({super.key});

  @override
  State<ContagemStatefull> createState() => _ContagemStatefullState();
}

class _ContagemStatefullState extends State<ContagemStatefull> {
  int contador = 0;

  void aumentar() {
    setState(() {
      contador++;
    });
    checarEspecial();
  }

  void reduzir() {
    setState(() {
      contador--;
    });
    checarEspecial();
  }

  void zerar() {
    setState(() {
      contador = 0;
    });
    checarEspecial();
  }

  void checarEspecial() {
    if (contador % 10 == 0 && contador != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você chegou a $contador cliques!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String getMensagem() {
    if (contador < 0) return 'Você está indo mal';
    if (contador == 0) return 'Comece a clicar';
    if (contador < 10) return 'Continue a clicar';
    if (contador < 20) return 'Não desista!';
    return 'Clique Master';
  }

  Color getCor() {
    if (contador < 0) return Colors.red.shade100;
    if (contador == 0) return Colors.grey.shade200;
    if (contador < 10) return Colors.yellowAccent.shade100;
    if (contador < 20) return Colors.blueAccent.shade100;
    return Colors.green.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contagem de cliques!'), centerTitle: true),
      backgroundColor: getCor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                '$contador',
                key: ValueKey(contador),
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(getMensagem(), style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
      bottomNavigationBar: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Aumentar', style: TextStyle(color: Colors.white)),
                onPressed: aumentar,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 50),
                  backgroundColor: Colors.lightGreen,
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.exposure_zero, color: Colors.white),
                label: Text('Zerar', style: TextStyle(color: Colors.white)),
                onPressed: zerar,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 50),
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.remove, color: Colors.white),
                label: Text('Reduzir', style: TextStyle(color: Colors.white)),
                onPressed: reduzir,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(130, 50),
                  backgroundColor: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
