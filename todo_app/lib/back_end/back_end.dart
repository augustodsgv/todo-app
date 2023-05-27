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

// Função que faz a requisição na api e retorna uma string do json
Future<String> APIPost() async {
  final url = Uri.parse('https://api.notion.com/v1/databases/$database/query');
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
  var url = Uri.parse('https://api.notion.com/v1/blocks/$id');
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

// Função que envia uma mensagem patch para a api
Future<bool> pagePatch() async {
  var url = Uri.parse(
      'https://api.notion.com/v1/databases/de6b05c4fbf34b3e92a74b7f1c380b6a');

  var contentBody = jsonEncode({
    "title": [
      {
        "text": {"content": "jajaja"}
      }
    ],
    "description": [
      {
        "text": {"content": ""}
      }
    ]
  });

  //print(contentBody);
  const header = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'aplication/json',
    'Notion-Version': '2022-06-28'
  };

  var response = await http.patch(url, headers: header, body: contentBody);

  if (response.statusCode == 200) {
    print('status code : ${response.statusCode}');
    print(response.body);
    return true;
  }

  print('status code : ${response.statusCode}');
  print(response.body);

  return false;
}

Future<bool> updatePage(id, property, newValue, valueType) async {
  var url = Uri.http('api.notion', 'v1/pages$id');
  const header = {
    'Authorization': 'Bearer $token',
    'Contente-Type': 'aplication/json',
    'Notion-Version': '2022-06-28'
  };

  String contentBody = jsonEncode({
    'properties': {
      '$property': {'valueType': newValue}
    }
  });

  var response = await http.patch(url, headers: header, body: contentBody);

  if (response.statusCode == 200) {
    print(response.statusCode);
    print(response.body);
    return true;
  }

  print(await response.statusCode);
  print(await response.body);

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
  //print(await APIPost());
  print(await deletePage("f3b9835d-343f-4925-bff6-3b1e55f13c2d"));
}
