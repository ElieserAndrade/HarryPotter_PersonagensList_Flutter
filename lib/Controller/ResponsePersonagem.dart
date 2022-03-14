import 'dart:async';
import 'dart:convert';
import 'package:harry_potter/Model/Personagem.dart';
import 'package:http/http.dart' as http;

class Servicos {
  //Future<dynamic> getPersonagem() async {
   // List<Personagem> personagens = [];
   // String url = 'http://hp-api.herokuapp.com/api/characters';
   // var response = await http.get(Uri.parse(url));

   // if (response.statusCode == 200) {
    //  List responseJson = jsonDecode(response.body);
  //    responseJson.map((e) => personagens.add(Personagem.fromJson(e))).toList();
  //  } else {
    //  throw ('erro');
   // }

  //  print(response.body);
//  }


 Future<List<Personagem>> getPersonagem() async {
   final response = await http
      .get(Uri.parse('http://hp-api.herokuapp.com/api/characters'));
 
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    
   
    return parsed.map<Personagem>((json) => Personagem.fromMap(json)).toList();
    
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
}