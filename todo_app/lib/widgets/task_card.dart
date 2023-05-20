/**
 * Programa : home_page.dart
 * Descrição : Card das tarefas
 * Autor : Augusto dos Santos
 * Última edição : 28/04/2023
 */
///
///

import 'package:flutter/material.dart';
import 'package:todo_app/cores.dart';
import 'check_box.dart';

class TaskCard extends StatefulWidget {
  final String texto;
  final bool isChecked;

  const TaskCard({super.key, required this.texto, required this.isChecked});

  @override
  _StateTaskCard createState() => _StateTaskCard();
}

class _StateTaskCard extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          height: 75,
          child: Card(
            color: taskCardColor, // Cor do card
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.texto,
                    style: TextStyle(color: taskCardColorText, fontSize: 20),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckingBox(isChecked: widget.isChecked),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
