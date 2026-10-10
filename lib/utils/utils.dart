
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:payment_app/utils/color_page.dart';

class Utils {


  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: UIColor.redColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}