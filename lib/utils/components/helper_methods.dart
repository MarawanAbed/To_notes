import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HelperMethod {
  static Future<File> getImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }


  static Future<File> getImageFromCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    return File(pickedFile!.path);
  }

  static String showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  // static String showGenres(List<GenresModel> genres) {
  //   return genres.map((genre) => genre.name).join(', ');
  // }
  // static SizedBox verticalSpace(double height) => SizedBox(
  //   height: height.h,
  // );
  //
  // static SizedBox horizontalSpace(double width) => SizedBox(
  //   width: width.w,
  // );
  static showErrorToast(String msg,
      {Color? color, ToastGravity? gravity}) async {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showSuccessToast(String msg,
      {Color? color, ToastGravity? gravity}) async {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //show data picker
  static Future<String> datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return picked.toString();
    }
    return '';
  }

  static String formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final String formatter = DateFormat('yyyy-MM-dd').format(dateTime);
    return formatter;
  }

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  //dialog for loading
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
