import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Ticket Date Time For Booking
/// ====
enum TicketDateTime {
  sevenTo9am(title: '7 AM - 9 AM', start: 7, end: 9),
  nineTo11am(title: '9 AM - 11 AM', start: 9, end: 11),
  twelveTo2pm(title: '12 PM - 2 PM', start: 12, end: 14),
  threeTo5pm(title: '3 PM - 5 PM', start: 15, end: 17),
  sixTo8pm(title: '6 PM - 8 PM', start: 18, end: 20),
  nineTo11pm(title: '9 PM - 11 PM', start: 21, end: 23);

  final String title;
  final int start;
  final int end;
  const TicketDateTime(
      {required this.title, required this.start, required this.end});

  ///Tickit Listing on first Row
  ///===
  static List<TicketDateTime> get firstRow =>
      [sevenTo9am, nineTo11am, twelveTo2pm];

  ///Tickit Listing on second Row
  ///===
  static List<TicketDateTime> get secondRow =>
      [threeTo5pm, sixTo8pm, nineTo11pm];
}

extension WatchingTime on TicketDateTime {
  /// Ticket Booking Date Time
  /// ===
  DateTimeRange bookingDateTime(String date) {
    DateTime onDate = DateFormat('dd-MM-yyyy').parse(date);
    switch (this) {
      case TicketDateTime.sevenTo9am:
        return DateTimeRange(
          start: onDate.add(Duration(hours: start)),
          end: onDate.add(Duration(hours: end)),
        );
      case TicketDateTime.nineTo11am:
        return DateTimeRange(
          start: onDate.add(Duration(hours: start)),
          end: onDate.add(Duration(hours: end)),
        );
      case TicketDateTime.twelveTo2pm:
        return DateTimeRange(
          start: onDate.add(Duration(hours: start)),
          end: onDate.add(Duration(hours: end)),
        );
      case TicketDateTime.threeTo5pm:
        return DateTimeRange(
          start: onDate.add(Duration(hours: start)),
          end: onDate.add(Duration(hours: end)),
        );
      case TicketDateTime.sixTo8pm:
        return DateTimeRange(
          start: onDate.add(Duration(hours: start)),
          end: onDate.add(Duration(hours: end)),
        );
      case TicketDateTime.nineTo11pm:
        return DateTimeRange(
          start: onDate.add(Duration(hours: start)),
          end: onDate.add(Duration(hours: end)),
        );
    }
  }

  // DateTime get startDate => bookingDateTime('').start;
  // DateTime get endDate => bookingDateTime('').end;
}
