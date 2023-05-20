/**
 * Programa : home_page.dart
 * Descrição : Botão do "adicionar tarefa"
 * Autor : Augusto dos Santos
 * Última edição : 28/04/2023
 */
///
import 'package:flutter/material.dart';
import 'package:todo_app/cores.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {}, // Função de quando se pressiona o botão
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: corBotaoAdd, // Cor do botão
      ),
      child: Icon(Icons.add, color: corBotaoAddIcon), // Ícone do botão
    );
  }
}