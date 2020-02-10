
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:http/http.dart" as http;
import 'package:lgoin/controller/inventory_controller.dart';
import 'package:lgoin/main.dart';
import 'package:lgoin/models/item.dart';

import 'dart:async';
import 'dart:convert';

import 'package:lgoin/screens/home/display/inventory/description.dart';

class Inventory extends StatefulWidget {
  final String sheetId;
  Inventory(this.sheetId);
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  

  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds:2));
    setState(() {
       getUser(widget.sheetId);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0.0,
        
        title: Text(
          "Inventory",
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
        backgroundColor: darkThemeEnabled ? Colors.black : Colors.white,),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          color:darkThemeEnabled ? Colors.black : Colors.white,
          child: StreamBuilder<List<Users>>(
            stream: getUser(widget.sheetId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return SpinKitFadingCircle(
                  color: Colors.orange,
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        
                         index == 0 ? SizedBox(height: 12.0) : SizedBox(height:0.0),
                      
                        ListTile(
                          // trailing: Divider(),
                          // isThreeLine: true,
                          contentPadding: EdgeInsets.only( left: 15.0,right: 12.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  snapshot.data[index].name,
                                 
                                style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              Text( "x" + snapshot.data[index].quantities.toString(),
                              style: TextStyle(
                                  fontFamily: "Muli",
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12.0,
                                  // fontWeight: FontWeight.bold,
                                ),)
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(snapshot.data[index].about,
                             overflow: TextOverflow.ellipsis,
                            maxLines: 2,),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        Description(snapshot.data[index])));
                          },
                          // leading: Text("Wanted to know More..."),
                        ),
                        Divider(color: darkThemeEnabled? Colors.white70 : Colors.grey),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
