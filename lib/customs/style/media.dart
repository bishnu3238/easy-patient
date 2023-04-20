import 'package:flutter/cupertino.dart';

class Media {
  double width = 0.0;
  double height= 0.0;
  Media({ this.height = 0.0,  this.width=0.0});
  double get phoneWidth => width;
  double get phoneHeight => height;

  media(context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}
