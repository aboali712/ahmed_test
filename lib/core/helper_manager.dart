import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


toastApp(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);


}

toastAppSuccess(String msg, BuildContext context) {
  return ElegantNotification(
    iconSize: 26,
    width: MediaQuery.of(context).size.width,
    height: 50,
    displayCloseButton: false,
    description: Text(
      msg,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
    ),
    icon: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    ),
    progressIndicatorColor: Colors.lightGreen,
  ).show(context);
}




