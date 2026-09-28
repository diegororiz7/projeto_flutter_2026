import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GerenciadorTarefas(),
    );
  }
}

class GerenciadorTarefas extends StatefulWidget {
  const GerenciadorTarefas({super.key});

  @override
  State<GerenciadorTarefas> createState() => _GerenciadorTarefasState();
}

class _GerenciadorTarefasState extends State<GerenciadorTarefas> {
  final TextEditingController nomeController = TextEditingController();

  String prioridade = 'Média';

  List<Map<String, dynamic>> tarefas = [];

  void adicionarTarefa() {
    if (nomeController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      tarefas.add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'nome': nomeController.text,
        'concluida': false,
        'prioridade': prioridade,
        'favorita': false,
      });

      nomeController.clear();
      prioridade = 'Média';
    });
  }

  void excluirTarefa(int id) {
    setState(() {
      tarefas.removeWhere((item) => item['id'] == id);
    });
  }

  void concluirTarefa(int id) {
    setState(() {
      for (var item in tarefas) {
        if (item['id'] == id) {
          item['concluida'] = !item['concluida'];
        }
      }
    });
  }

  void favoritarTarefa(int id) {
    setState(() {
      for (var item in tarefas) {
        if (item['id'] == id) {
          item['favorita'] = !item['favorita'];
        }
      }
    });
  }

  Color corPrioridade(String prioridade) {
    if (prioridade == 'Alta') {
      return Colors.red.shade200;
    }

    if (prioridade == 'Média') {
      return Colors.orange.shade200;
    }

    return Colors.green.shade200;
  }

  @override
  Widget build(BuildContext context) {
    int concluidas = tarefas.where((item) => item['concluida'] == true).length;

    int pendentes = tarefas.length - concluidas;

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciador de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: prioridade,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'Alta', child: Text('Alta')),
                DropdownMenuItem(value: 'Média', child: Text('Média')),
                DropdownMenuItem(value: 'Baixa', child: Text('Baixa')),
              ],
              onChanged: (valor) {
                setState(() {
                  prioridade = valor!;
                });
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: adicionarTarefa,
                child: const Text('Adicionar tarefa'),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: ${tarefas.length}'),
                Text('Concluídas: $concluidas'),
                Text('Pendentes: $pendentes'),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = tarefas[index];

                  return Card(
                    color: corPrioridade(tarefa['prioridade']),
                    child: ListTile(
                      onTap: () {
                        concluirTarefa(tarefa['id']);
                      },
                      title: Text(
                        tarefa['nome'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: tarefa['concluida']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text('Prioridade: ${tarefa['prioridade']}'),
                      leading: IconButton(
                        onPressed: () {
                          favoritarTarefa(tarefa['id']);
                        },
                        icon: Icon(
                          tarefa['favorita'] ? Icons.star : Icons.star_border,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          excluirTarefa(tarefa['id']);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
