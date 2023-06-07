// COLORS
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
const String imageUrl = 'https://image.tmdb.org/t/p/w500/';
const String ifImageNull = 'https://picsum.photos/200/300';

InputDecoration inputDecoration = InputDecoration(
  // labelText: labelText,
  // prefixIcon: Icon(icon),
  labelStyle: const TextStyle(
    fontSize: 20,
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: borderColor,
      )),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: borderColor,
      )),
);


// flutter pub run build_runner build --delete-conflicting-outputs

// final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: Colors.white,
//     primaryColor: Colors.black,
//     textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
//     colorScheme:
//         ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange));

// final ThemeData darkTheme = ThemeData(
//   scaffoldBackgroundColor: Colors.black,
//   brightness: Brightness.dark,
//   // primaryColor: Colors.white,
//   colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
// );
