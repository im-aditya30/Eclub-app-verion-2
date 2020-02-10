import 'package:flutter/material.dart';
import 'package:lgoin/main.dart';
import 'package:lgoin/models/item.dart';



class Description extends StatelessWidget {
  final Users user;
  Description(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0.0,
        iconTheme: IconThemeData(color:darkThemeEnabled ? Colors.white : Colors.black),
        title: Text(
          user.name,
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
        backgroundColor: darkThemeEnabled ? Colors.black : Colors.white,
          
      ),
      body: Container(
        color: darkThemeEnabled ? Colors.black : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ListView(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.network(user.picture),
            ),
            SizedBox(height: 10.0,),
            Text(
              user.description,
              textAlign: TextAlign.center,
              // maxLines: 2,
              
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 16.0,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
