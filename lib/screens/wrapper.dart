import 'package:flutter/material.dart';
import 'package:lgoin/screens/authenticate/authenticate.dart';
import 'package:lgoin/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:lgoin/models/user.dart';


class Wrapper extends StatefulWidget {
  // final Function toggleTheme;
 

  Wrapper();
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

    
  @override
  Widget build(BuildContext context) {


    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}