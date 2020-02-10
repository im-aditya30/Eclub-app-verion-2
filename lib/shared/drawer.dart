import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lgoin/main.dart';
import 'package:lgoin/models/user.dart';
import 'package:lgoin/screens/home/display/input_data.dart';
import 'package:lgoin/screens/home/display/inventory/inventory.dart';
import 'package:lgoin/services/auth.dart';
import 'package:lgoin/services/database.dart';
import 'package:provider/provider.dart';
import './listtile.dart';

class Drawerlist extends StatefulWidget {
  final bool selected1;
  final bool selected2;
  final bool selected3;
  Drawerlist(
      { this.selected1, this.selected2, this.selected3});
  @override
  _DrawerlistState createState() => _DrawerlistState();
}

class _DrawerlistState extends State<Drawerlist> {
  FirebaseUser user;
  final AuthService _authe = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget firstName(context, String nameof) {
    if (nameof == null) {
      return SpinKitRotatingCircle(
        color: Colors.indigoAccent[700],
        size: 40.0,
      );
    }
    return Text(nameof[0].toUpperCase(),
        style: TextStyle(fontSize: 40.0, color: Colors.indigoAccent[700]));
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream:
            (user.uid != null) ? DatabaseService(uid: user.uid).userData : null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              backgroundColor: Colors.orange,
            );
          } else {
            UserData userData = snapshot.data;
            return new Drawer(
              child: Container(
                // color: Colors.black87,
                child: new ListView(
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 200.0,
                      padding: EdgeInsets.all(0.0),
                      color: darkThemeEnabled
                          ?  Colors.indigo[900]: Colors.deepPurpleAccent[700],
                          
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Center(
                              child: firstName(context, userData.name),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          userData.name != null
                              ? Text(
                                  userData.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                )
                              : SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                          SizedBox(
                            height: 1.0,
                            width: 20.0,
                          ),
                          userData.email != null
                              ? Text(
                                  userData.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                )
                              : SpinKitThreeBounce(
                                  color: Colors.orange,
                                  size: 15.0,
                                ),
                          
                        ],
                      ),
                    ),
                    TileList(widget.selected1, () {
                      Navigator.of(context).pop();
                    }, Icons.gradient, "Scan Qr Code"),   
                    
                    
                    TileList(widget.selected2, () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Inventory("all")));
                    }, Icons.list, "Inventory"),

                     TileList(widget.selected2, () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new AddItem()));
                    }, Icons.add, "Add New Item"),
                    Container(
      padding: EdgeInsets.all(0.0),
      
        child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            height: 55.0,
            //  color:widget.darkThemeEnabled ? Colors.indigoAccent[400] : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.lightbulb_outline,
                      size: 25.0,
                      color: Colors.blueAccent[700],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Dark Mode",
                        
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueAccent[700]),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Switch(
                      activeColor: Colors.blueAccent[700],
                      inactiveTrackColor: Colors.blueAccent[700],
                      inactiveThumbColor: Colors./*blue[300]*//*indigoAccent[100]*/white,
                      value: darkThemeEnabled,
                      onChanged: bloc.changeTheme,
                    ),
                  ],
                )
              ],
            )),
    ),

                    Divider(
                      color: Colors.blueGrey,
                    ),
                    TileList(false, () async {
                      await _authe.signOut();
                    }, Icons.exit_to_app, "Logout"),
                  ],
                ),
              ),
            );
          }
        });
  }
}
