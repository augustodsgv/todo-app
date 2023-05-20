/**
 * Programa : check_box.dart
 * Descrição : check box
 * Autor : Augusto dos Santos
 * Última edição : 28/04/2023
 */
///
import 'package:flutter/material.dart';
import 'package:todo_app/cores.dart';

class CheckingBox extends StatefulWidget {
  bool isChecked;
  CheckingBox({super.key, required this.isChecked});

  @override
  _StateCheckBox createState() => _StateCheckBox();
}

class _StateCheckBox extends State<CheckingBox> {
  // Função que define as cores da check box de acordo com a ação do usuário
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> estados = <MaterialState>{
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.pressed
    };

    if (states.any(estados.contains)) {
      // Caso haja alguma ação
      return checkedColor;
    } // Caso o usuário não faça nada
    return unCheckedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        checkColor: checkColor, // Cor do "v"
        fillColor: MaterialStateColor.resolveWith(getColor),
        value: widget.isChecked,
        onChanged: (bool? value) {
          setState(() {
            widget.isChecked = !widget.isChecked;
            // Função de mudar o status da task
          });
        });
  }
}
