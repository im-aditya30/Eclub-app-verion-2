import 'package:flutter/material.dart';
import 'package:lgoin/main.dart';
import 'package:lgoin/models/form.dart';
import 'package:lgoin/controller/form_controller.dart';




class AddItem extends StatefulWidget {
 

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController pictureController = TextEditingController();
  TextEditingController quantitiesController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sheetIdController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      NewItems newItems = NewItems(
        nameController.text, 
        pictureController.text, 
        quantitiesController.text, 
        aboutController.text,
        descriptionController.text,
        sheetIdController.text,
        // "insert"
      );
print(nameController.text +
        pictureController.text +
        quantitiesController.text +
        aboutController.text +
        descriptionController.text +
        sheetIdController.text
        );
      FormController formController = FormController((String response) {
          print("Response: $response");
          if (response == FormController.STATUS_SUCCESS) {
            // Feedback is saved succesfully in Google Sheets.
            _showSnackbar("Succesfully Added Data");
          } else {
            // Error Occurred while saving data in Google Sheets.
            _showSnackbar("Error Occurred!");
          }
        }
      );
     
      _showSnackbar("Adding Data");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(newItems);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
      final snackBar = SnackBar(content: Text(message));
      _scaffoldKey.currentState.showSnackBar(snackBar); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Add New Item",
        style: TextStyle(
            color:darkThemeEnabled ? Colors.white : Colors.black
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: IconThemeData(color:darkThemeEnabled ? Colors.white : Colors.black),
        backgroundColor: darkThemeEnabled ? Colors.black : Colors.white,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child:
                  Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name'
                        ),
                      ),
                      TextFormField(
                        controller: pictureController,
                        validator: (value) {
                          if (!value.isNotEmpty/*contains("https://wwww.")*/) {
                            return 'Enter a Valid Picture URL';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Picture URL'
                        ),
                      ),
                      TextFormField(
                        controller: quantitiesController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Number of Quantities';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantities',
                        ),
                      ),
                      TextFormField(
                        controller: aboutController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'A one line description is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'About'
                        ),
                        
                      ),
                      TextFormField(
                        controller: descriptionController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Description is Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Description'
                        ),
                      ),
                      TextFormField(
                        controller: sheetIdController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'SheetName is Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Sheet Name'
                        ),
                      ),
                    ],
                  ),
                ) 
              ),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed:_submitForm,
                child: Text('Add Data'),
              ),
            ],
          ),
      ),
      );
  }
}