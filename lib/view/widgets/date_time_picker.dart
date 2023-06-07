import 'package:chalchitr/controller/ticket_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../services/enum/ticket_enum.dart';

class DateTimePicker extends StatelessWidget {
  final TicketBookingController controller;
  const DateTimePicker({required this.controller, super.key});

  void setTicketTime(TicketDateTime time, index) {
    int tiketTime = time
        .bookingDateTime(controller.selectedDate)
        .start
        .millisecondsSinceEpoch;
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now < tiketTime) {
      controller.time = time;
      controller.buttonIndex.value = index;
    } else {
      Get.snackbar('Time over', 'You Can\'t Book', backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: true,
          controller: controller.dateController..text = controller.selectedDate,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(pickedDate);
              controller.selectedDate = formattedDate;
              controller.dateController.text = formattedDate;
            } else {}
            controller.buttonIndex.value = 0;
          },
          decoration: inputDecoration.copyWith(
              labelText: 'Select Date',
              suffixIcon: const Icon(Icons.calendar_month_outlined)),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            'Select Time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            TicketDateTime.firstRow.length,
            (index) => InkWell(
              onTap: () =>
                  setTicketTime(TicketDateTime.firstRow[index], index + 1),
              child:
                  chipButton(TicketDateTime.firstRow[index].title, index + 1),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            TicketDateTime.secondRow.length,
            (index) => InkWell(
              onTap: () =>
                  setTicketTime(TicketDateTime.secondRow[index], index + 4),
              child:
                  chipButton(TicketDateTime.secondRow[index].title, index + 4),
            ),
          ),
        ),
      ],
    );
  }

  Obx chipButton(title, int index) {
    return Obx(() {
      return Chip(
        backgroundColor:
            controller.buttonIndex.value == index ? Colors.red : null,
        label: Text(title),
      );
    });
  }
}
