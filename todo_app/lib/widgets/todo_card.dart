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

class TodoCard extends StatefulWidget {
  final String texto;
  bool isChecked;

  TodoCard({super.key, required this.texto, required this.isChecked});

  @override
  _StateTodoCard createState() => _StateTodoCard();
}

class _StateTodoCard extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    // Função que devolve a cor do checkbox
    Color getColor(Set<MaterialState> states) {
      if (states.any({MaterialState.hovered}.contains)) {
        return Colors.white;
      }
      return corSecundaria;
    }

    return Expanded(
        child: Card(
            color: corSecundaria, // Cor do card
            child: CheckingBox(isChecked : false)));
  }
}
