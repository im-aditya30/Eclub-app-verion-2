
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lgoin/models/item.dart';

class Send{
  final String _sheetId;
  final String _action = "getData";
  Send(this._sheetId);
  String toParam() => 
  "?sheetId=$_sheetId&action=$_action";
}

  // Future<List<Users>> getUser(String sheetId) async {
  //   // Users send;
  //   Send send = Send(sheetId);
  //   var data =
  //       await http.get(
  //         "https://script.google.com/macros/s/AKfycbwymBD74BHVbaQbhqIhCvn_jwZcdL9LjA7c5rL0aNkcIbFXUXgR/exec" + send.toParam()
  //         );
  //   var jsonData = json.decode(data.body);

  //   List<Users> users = [];
  //   for (var u in jsonData["user"]) {
  //     Users user = Users(
  //         u["index"], u["name"], u["picture"],u["quantities"], u["about"], u["description"]);
  //     users.add(user);
  //   }
  //   return users;
  // }

   Stream<List<Users>> getUser(String sheetId) async* {
    // Users send;
    Send send = Send(sheetId);
    var data =
        await http.get(
          "https://script.google.com/macros/s/AKfycbwymBD74BHVbaQbhqIhCvn_jwZcdL9LjA7c5rL0aNkcIbFXUXgR/exec" + send.toParam()
          );
    var jsonData = json.decode(data.body);

    List<Users> users = [];
    for (var u in jsonData["user"]) {
      Users user = Users(
          u["index"], u["name"], u["picture"],u["quantities"], u["about"], u["description"]);
      users.add(user);
    }
    yield users;
  }
