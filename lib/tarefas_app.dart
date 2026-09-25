import 'package:flutter/material.dart';

void main() {
  runApp(const TarefasApp());
}

class TarefasApp extends StatelessWidget {
  const TarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TarefasPage(),
    );
  }
}

class TarefasPage extends StatefulWidget {
  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {

  final TextEditingController nomeController = TextEditingController();

  String prioridade = 'Média';

  List<Map<String, dynamic>> tarefas = [];

  void adicionar{
    
  }

  void remover(int id) {

  }

  void concluir(int id) {

  }

  void favoritar(int id) {

  }

  Color corCard(String prioridade) {

  }

  int get concluidas =>
      tarefas.where((tarefa) => tarefa['concluida']).length;

  int get pendentes =>
      tarefas.length - concluidas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciador de Tarefas'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da tarefa',
              ),
            ),

            DropdownButton<String>(
              //value: 
              //onChanged: 
              items: const [
                DropdownMenuItem(
                  value: 'Alta',
                  child: Text('Alta'),
                ),
                DropdownMenuItem(
                  value: 'Média',
                  child: Text('Média'),
                ),
                DropdownMenuItem(
                  value: 'Baixa',
                  child: Text('Baixa'),
                ),
              ],
            ),

            ElevatedButton(
              //onPressed:
              child: const Text('Adicionar tarefa'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Total: ${}'),
                Text('Concluídas: ${}'),
                Text('Pendentes: ${}'),
              ],
            ),

            Expanded(
              child: ListView.builder(
                //itemCount:
                itemBuilder: (context, index) {

                  final tarefa = tarefas[index];

                  return Card(
                    //color:

                    child: ListTile(

                      onTap: () {

                      },

                      leading: IconButton(
                        //icon:
                        //onPressed:
                      ),

                      title: Text(
                        tarefa['nome'],
                        style: TextStyle(
                          //decoration:
                        ),
                      ),

                      subtitle: Text(
                        tarefa['prioridade'],
                      ),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        //onPressed:
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
