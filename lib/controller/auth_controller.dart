import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/app_route.dart';
import '../constant/constant.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // final FirebaseAuth auth = FirebaseAuth.instance;
  User? _user;
  RxBool processing = false.obs;

  @override
  void onInit() {
    super.onInit();
    _user = auth.currentUser;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _setInitialScreen(_user));
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      // Get.offAllNamed(AppRoute.login);
    } else {
      Get.offAllNamed(AppRoute.home);
    }
  }

  bool validateEmailPassword({bool isRegister = false}) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    emailRegex.hasMatch(email);
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar('Email', 'Please Enter valid Email');
      return false;
    }
    if (password.length < 5) {
      Get.snackbar('Password', 'Password shoud be at least 6 digit');
      return false;
    }
    if (!isRegister && (password != confirmPasswordController.text.trim())) {
      Get.snackbar(
          'Password', 'password and confirm password not match message');
      return false;
    }
    return true;
  }

  Future<void> signUp() async {
    processing.value = true;

    try {
      if (validateEmailPassword()) {
        await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        Get.offAllNamed(AppRoute.home);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    processing.value = false;
  }

  Future<void> signIn() async {
    processing.value = true;

    try {
      if (validateEmailPassword(isRegister: true)) {
        await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }

    Get.offAllNamed(AppRoute.home);
    processing.value = false;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
