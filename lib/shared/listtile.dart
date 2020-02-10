import 'package:flutter/material.dart';
import 'package:lgoin/main.dart';


class TileList extends StatelessWidget {
  final Function _onTap;
  final bool _selected;
  final IconData icon;
  final String data;
  TileList(this._selected, this._onTap, this.icon, this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: InkWell(
        splashColor: Colors.blue[700],
        onTap: _onTap,
        child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            height: 55.0,
             color: darkThemeEnabled ? _selected ? Colors.grey[800]/*indigoAccent[400]*/ : Colors.transparent
             : _selected ? Colors./*grey[800]*/indigoAccent[400] : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 25.0,
                      color: _selected ? Colors.white : Colors.blueAccent[700],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        data,
                        
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: _selected
                                ? Colors.white
                                : Colors.blueAccent[700]),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_right,
                      size: 30.0,
                      color: _selected ? Colors.white : Colors.blueAccent[700],
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
