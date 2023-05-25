/**
 * Programa : home_page.dart
 * Descrição : Página principal (e única) do programa "todo-app"
 * Autor : Augusto dos Santos
 * Última edição : 28/04/2023
 */
///
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_list.dart';
import 'package:todo_app/cores.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: corBackgroud, body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TaskList(),
      )),
    );
  }
}
