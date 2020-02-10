import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  final Color color;
  Loading(this.color);
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Center(
        child: SpinKitRotatingCircle(
          color: Colors.deepOrange,
          size: 50.0,
        ),
      ),
    );
  }
}