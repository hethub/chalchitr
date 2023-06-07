import 'package:chalchitr/controller/auth_controller.dart';

import 'package:chalchitr/view/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

import '../../app/app_route.dart';
import '../../constant/constant.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const route = AppRoute.login;
  static GetPage page = GetPage(
      name: LoginScreen.route,
      page: LoginScreen.new,
      preventDuplicates: true,
      binding: BindingsBuilder.put(() => AuthController()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chalchitr'.toUpperCase(),
            style: TextStyle(
              fontSize: 35,
              color: buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: controller.emailController,
              labelText: 'Email',
              icon: Icons.email,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: controller.passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              isObscure: true,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(() {
            return Visibility(
              visible: !controller.processing.value,
              replacement: Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    await controller.signIn();
                  },
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account? ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              InkWell(
                onTap: () {
                  // Get.offAllNamed(AppRoute.signup);
                  Get.toNamed(AppRoute.signup);
                },
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: buttonColor),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
