import 'package:chalchitr/app/app_route.dart';
import 'package:chalchitr/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/ticket_detail_model.dart';
import '../services/database/ticket_database.dart';
import '../services/enum/ticket_enum.dart';

class TicketBookingController extends GetxController {
  final TextEditingController dateController = TextEditingController();
  int movieID = 0;
  String customerName = '';
  String customerEmail = auth.currentUser?.email ?? '';
  int customerID = 0;
  int contactNumber = 0;
  String movieTitle = '';
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  TicketDateTime? time;
  RxInt buttonIndex = 0.obs;
  set setMovieID(int id) {
    movieID = id;
  }

  void onBook() async {
    if (buttonIndex.value != 0) {
      DateTimeRange watchingTime = time!.bookingDateTime(selectedDate);
      TicketDetail input = TicketDetail(
        movieID: movieID,
        contactNumber: contactNumber,
        email: customerEmail,
        customerID: customerID,
        movieTitle: movieTitle,
        customerName: customerName,
        movieStartTime: watchingTime.start.millisecondsSinceEpoch,
        movieEndTime: watchingTime.end.millisecondsSinceEpoch,
      );

      await TicketsQuery().insertTicketINDB(input);

      Get.offAllNamed(AppRoute.home);
      Get.snackbar('Booking successfull', 'Your Ticket is successfully Booked',
          backgroundColor: Colors.green);
    } else {
      Get.snackbar('Select Time', 'Please Select Booking time',
          backgroundColor: Colors.red);
    }
  }
}
