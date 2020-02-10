import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lgoin/main.dart';
import 'package:lgoin/screens/home/display/inventory/inventory.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:qrscan/qrscan.dart' as scanner;

class QrScanner extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}


class _QrScannerState extends State<QrScanner> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);

  @override
  initState() {
    super.initState();
  }

  bool _show = true;
  bool loading = false;
  double width = 120.0;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              scan();
              loading = true;
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0)),
            color: darkThemeEnabled
                ? Colors.blueAccent[700]
                : Colors.pinkAccent[400],
            splashColor: Colors.purpleAccent[400],
            padding: const EdgeInsets.fromLTRB(14.0, 16.0, 16.0, 16.0),
            child: Container(
              height: 40.0,
              width: 253.0,
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          size: 35.0,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Scan Qr Code",
                            style: TextStyle(
                              fontSize: 27.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
  // }

  Future scan() async {
    try {
      String barcodeGet = await scanner.scan();
      setState(() {
        _show = !_show;
        barcode = barcodeGet;
        loading = false;
      });
    } on FormatException {
      setState(() {
        loading = false;
      });
    } on PlatformException catch (e) {
      if (e.code == scanner.CameraAccessDenied) {
        setState(() {
          loading = false;
          error = "Camera Permission Required";
        });
      } else {
        setState(() {
          loading = false;
          error = "Unknown Error $e";
        });
      }
    } catch (e) {
      loading = false;
      print(e);
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var heig;
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0),left: Radius.circular(20.0))),
              /* child: Container(
              width: 150.0,
              height: barcode.length < 22 ? 90.0 : 140.0,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: Text(
                        '$barcode',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: barcode.length < 22
                              ? 22.0
                              : (barcode.length < 54 ? 18.0 : 15.0),
                        ),
                        textAlign: barcode.length <= 99 ? TextAlign.center : TextAlign.left,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _scan();
                          Navigator.of(context).pop();
                        },
                        color: Colors.purpleAccent[700],
                        splashColor: Colors.purpleAccent,
                        // padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 3.0),
                        child: Container(
                          height: 20.0,
                          width: 130.0,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "Scan Again",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 3.0, top: 5.0, left: 2.0, right: 6.0),
                        child: FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blueAccent[400],
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            loading = false;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 6.0,
                      )
                    ],
                  ),
                ],
              ),
            ),*/
              child: Container(
                decoration: BoxDecoration(
                              //  color: Colors.purpleAccent[700],
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0),left: Radius.circular(20.0)),
                            ),
                  height: heig = 150.0,
                  width: 150.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          // width: double.infinity,
                          height: heig * 0.5,
                          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0,8.0),
                          child: Center(
                            child: Text(
                              '$barcode',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  
                                  fontSize: barcode.length< 22 ? 20 : 16,
                                )),
                          ),
                        ),

                        InkWell(
                            onTap: () {
                            scan();
                            Navigator.of(context).pop();
                          },
                          splashColor: Colors.purpleAccent,
                          child: Container(
                            decoration: BoxDecoration(
                               color: Colors.purpleAccent[700],
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(25.0),left: Radius.circular(25.0)),
                            ),
                            height: 40.0,
                            width: 160.0,
                           
                          
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "Scan Again",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ),
                          ),
                        InkWell(
                           child: Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Text(
                              'DISMISS',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontFamily: "Raleway",
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent[400],
                              ),
                          ),
                           ),
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Inventory(barcode)));
                          // Navigator.of(context).pop();
                            loading = false;
                          },
                        ),
                      
                      ],
                    ),
                  ));
        });
  }
}
