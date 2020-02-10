
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lgoin/models/form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using 
/// HTTP Post request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbwymBD74BHVbaQbhqIhCvn_jwZcdL9LjA7c5rL0aNkcIbFXUXgR/exec";
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  // Default Contructor
  FormController(this.callback);

  /// Async function which saves feedback, parses [NewItems] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(NewItems newItems) async {
    try {
      await http.get(
        URL + newItems.toParams()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
        print(json.decode(response.body));
      });
       
       
    } catch (e) {
      print(e);
    }
  }
}