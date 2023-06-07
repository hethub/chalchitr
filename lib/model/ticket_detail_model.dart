class TicketDetail {
  final int movieID;
  final String customerName;
  final String email;
  final int customerID;
  final int contactNumber;
  final String movieTitle;

  final int movieStartTime;
  final int movieEndTime;

  const TicketDetail({
    required this.movieID,
    required this.contactNumber,
    required this.email,
    required this.customerID,
    required this.movieTitle,
    required this.customerName,
    required this.movieStartTime,
    required this.movieEndTime,
  });

  factory TicketDetail.fromJson(Map<String, dynamic> map) {
    return TicketDetail(
        movieID: map['movieID'],
        contactNumber: map['contactNumber'],
        email: map['email'],
        customerID: map['customerID'],
        movieTitle: map['movieTitle'],
        customerName: map['customerName'],
        movieStartTime: map['movieStartTime'],
        movieEndTime: map['movieEndTime']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['movieID'] = movieID;
    map['contactNumber'] = contactNumber;
    map['email'] = email;
    map['customerID'] = customerID;
    map['movieTitle'] = movieTitle;

    map['customerName'] = customerName;
    map['movieStartTime'] = movieStartTime;
    map['movieEndTime'] = movieEndTime;
    return map;
  }
}
