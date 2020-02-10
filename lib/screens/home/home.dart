import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lgoin/main.dart';
import 'package:lgoin/models/user.dart';
import 'package:lgoin/shared/drawer.dart';
// import 'package:lgoin/screens/home/display/qrscan_cde/qr_code.dart';
import 'package:lgoin/screens/home/display/qrscan_cde/qr_scanner.dart';
import 'package:lgoin/services/auth.dart';
import 'package:lgoin/services/database.dart';
import 'package:lgoin/shared/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  // final Function toggleTheme;
  final AuthService _authe = AuthService();
 
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _show = true;
  void toggleView() {
    setState(() {
      _show = !_show;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you really want to exit?'),
            // content: new Text('Do you really want to exit'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text(
                  'Yes',
                  style: TextStyle(color: Colors.lightGreenAccent[400]),
                ),
              ),
              new FlatButton(
                color: Colors.amber[900],
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  String password;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          userData == null ? Loading(Colors.white) : password = userData.password;
          return WillPopScope(
            onWillPop: _onWillPop,
            child: new Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: darkThemeEnabled ? Colors.white : Colors.black,
                ),
                title: Text('Scan Qr Code',
                  style: TextStyle(
                    color:darkThemeEnabled ? Colors.white : Colors.black),),
                backgroundColor: darkThemeEnabled ? Colors.black : Colors.white,
                // elevation: 0.0,
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person,
                    color: Colors.white,),
                    label: Text('Logout',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: () async {
                      await widget._authe.signOut();
                    },
                  )
                ],
              ),
              drawer: Drawerlist(
                selected1: true,
                selected2: false,
                selected3: false,
              ),
              body: Container(
                // padding: EdgeInsets.only(top: 170.0),
                color: darkThemeEnabled ? Colors.black : Colors.white,
                // child: ListView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // (password == null)
                    //     ? SpinKitFadingCircle(
                    //         color: darkThemeEnabled ? Colors.white : Colors.black,
                    //       )
                    //     : QrCode(toggleView, _show, password,),
                    // SizedBox(
                    //   height: 15.0,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       'O',
                    //       style:
                    //           TextStyle(color: darkThemeEnabled ? Colors.white70 : Colors.black54, fontSize: 40.0),
                    //     ),
                    //     Text(
                    //       'R',
                    //       style:
                    //           TextStyle(color: darkThemeEnabled ? Colors.white70 : Colors.black54, fontSize: 32.0),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 15.0),
                    QrScanner(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
