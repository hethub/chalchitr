import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app_page.dart';
import 'app/app_route.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const Chalchitr());
}

class Chalchitr extends StatelessWidget {
  const Chalchitr({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chalchitr',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      initialRoute: AppRoute.login,
      getPages: AppPages.pages,
    );
  }
}
