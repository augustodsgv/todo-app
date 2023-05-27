/**
 * Programa : task_list.dart
 * Descrição : Lista dos cards de task
 * Autor : Augusto dos Santos
 * Última edição : 21/05/2023
 */
///
///

import 'package:flutter/material.dart';
import 'package:todo_app/back_end/back_end.dart';
import 'package:todo_app/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: makeTaskList(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key : UniqueKey(),
                  child: TaskCard(
                      texto: snapshot.data[index].taskText,
                      isChecked: snapshot.data[index].isChecked,
                      ID: snapshot.data[index].ID),
                  onDismissed: (direction) {
                    deletePage(snapshot.data[index].ID);
                  },
                );
              });
        });
  }
}
