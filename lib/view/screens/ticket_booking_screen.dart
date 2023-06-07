import 'package:chalchitr/constant/constant.dart';
import 'package:chalchitr/view/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/app_route.dart';
import '../../controller/ticket_booking_controller.dart';

class TicketBookingScreen extends GetView<TicketBookingController> {
  TicketBookingScreen({super.key});
  static const route = AppRoute.booking;
  static GetPage page = GetPage(
      name: TicketBookingScreen.route,
      page: TicketBookingScreen.new,
      preventDuplicates: true,
      binding: BindingsBuilder.put(() => TicketBookingController()));

  static const SizedBox space = SizedBox(height: 15);
  final _formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required*';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Book Ticket'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    space,
                    Center(
                      child: Text(
                        Get.arguments['title'],
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    space,
                    TextFormField(
                      validator: validator,
                      onSaved: (value) {
                        controller.customerName = value!;
                      },
                      decoration:
                          inputDecoration.copyWith(labelText: 'Customer Name'),
                    ),
                    space,
                    TextFormField(
                      initialValue: controller.customerEmail,
                      validator: validator,
                      onSaved: (value) {
                        controller.customerEmail = value!;
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Customer Email'),
                    ),
                    space,
                    TextFormField(
                      validator: validator,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (value) {
                        controller.customerID = int.tryParse(value!) ?? 0;
                      },
                      decoration:
                          inputDecoration.copyWith(labelText: 'Customer ID'),
                    ),
                    space,
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required*';
                        } else if (value.length != 10) {
                          return 'Contact Number must be 10 digits';
                        }
                        return null;
                      },
                      maxLength: 10,
                      onSaved: (value) {
                        controller.contactNumber = int.tryParse(value!) ?? 0;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: inputDecoration.copyWith(
                          labelText: 'Contact Number', counterText: ""),
                    ),
                    space,
                    TextFormField(
                      readOnly: true,
                      onSaved: (value) {
                        controller.movieTitle = Get.arguments['title'];
                      },
                      validator: validator,
                      initialValue: Get.arguments['title'],
                      decoration: inputDecoration.copyWith(
                        labelText: 'Movie Title',
                      ),
                    ),
                    space,
                  ],
                ),
              ),
              DateTimePicker(controller: controller),
              space,
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    controller.setMovieID = Get.arguments['movieID'];
                    controller.onBook();
                  } else {}
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Book Ticket',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
