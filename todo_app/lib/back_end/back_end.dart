/**
 * Programa : back_end.dart
 * Descrição : programa que conecta à api do notion
 * Autor : Augusto dos Santos
 * Última edição : 21/05/2023
 */
///
import 'package:http/http.dart' as http;
import 'dart:convert';

// Constantes da API
const database = 'de6b05c4fbf34b3e92a74b7f1c380b6a';
const token = 'secret_zqkq44nNPRwIaHHVQGlk2dlVsGgUeyHR5XbFiUXRKF2';
final url = Uri.https('api.notion.com', '/v1/databases/$database/query');

// Função que faz a requisição na api e retorna uma string do json
Future<String> APIPost() async {
  const header = {
    'Authorization': 'Bearer $token',
    'Notion-Version': '2022-06-28'
  };

  var response = await http.post(url, headers: header);

  return response.body;
}

// Função que trata a saída Json da API Notion de um tipo Text
String getText(json, index, propriedade) {
  return json['results'][index]['properties'][propriedade]['title'][0]['text']
      ['content'];
}

// Função que trata a saída Json da API Notion de um tipo Num
double getNum(json, index, propriedade) {
  return json['results'][index]['properties'][propriedade]['number'];
}

// Função que trata a saída Json da API Notion de um tipo checkbox
bool getBool(json, index, propriedade) {
  return json['results'][index]['properties'][propriedade]['checkbox'];
}

String getID(json, index) {
  return json['results'][index]['id'];
}

Future<bool> deletePage(id) async {
  var url = Uri.http('api.notion.com', '/v1/blocks/$id');
  const header = {
    'Authorization': 'Bearer $token',
    'Notion-Version': '2022-06-28'
  };

  var response = await http.delete(url, headers: header);

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    print('Deu bom');
    return true;
  }

  if (response.statusCode == 400) {
    print('Deu ruim');
    print(response.body);
    return false;
  }
  return false;
}

// Classe task que será usada para criar as tasks
class Task {
  // Atributos
  final String taskText;
  final bool isChecked;
  final String ID;

  // Construtor padrão
  Task(this.taskText, this.isChecked, this.ID);

  // Criador de json
  Map<String, dynamic> toJson() => {'task': taskText, 'isChecked': isChecked};
}

Future<List<Task>> makeTaskList() async {
  var jsonString = await APIPost();
  var json = jsonDecode(jsonString);
  List<Task> listaTasks = [];

  for (var i = 0; i < json['results'].length; i++) {
    var nome = getText(json, i, 'task');
    var isChecked = getBool(json, i, 'checked');
    var id = getID(json, i);
    Task tarefaAux = Task(nome, isChecked, id);
    listaTasks.add(tarefaAux);
  }

  return listaTasks;
}

void main() async {
  // Pegando o id do primeiro elemento
  var jsonString = await APIPost();
  var json = jsonDecode(jsonString);
  var id = getID(json, 0);
//print('Deletando ${getText(json, 0, 'task')}');
  deletePage(id);
}
