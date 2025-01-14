import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Dialogs {
  static error({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red[900],
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      fontSize: 15,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static sucess({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColors.oliveGreen,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      fontSize: 15,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static advertencia({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.grey[800],
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      fontSize: 15,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}

  /* static success({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColors.green,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.BOTTOM,
      fontSize: 18,
      toastLength: Toast.LENGTH_LONG,
    );
  } */

 
