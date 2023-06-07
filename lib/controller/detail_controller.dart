import 'package:chalchitr/model/movie_details.dart';
import 'package:get/get.dart';
import '../model/booked_ticket.dart';
import '../services/api/api_services.dart';
import '../services/database/ticket_database.dart';

class DetailController extends GetxController {
  final int movieId;
  DetailController({required this.movieId});
  final Rx<MoviesDetails> _movieDetails = Rx(MoviesDetails());
  final ApiServices apiServices = ApiServices();
  MoviesDetails get detail => _movieDetails.value;
  RxBool isLoading = false.obs;
  Ticket? isTicketBooked;
  RxString bookTicket = 'Book Ticket'.obs;

  @override
  void onInit() async {
    super.onInit();
    getMovieDetails();
    isTicketAblable();
  }

  Future<void> isTicketAblable() async {
    isTicketBooked = await TicketsQuery().getMovieByID(movieId);
    if (isTicketBooked != null) {
      bookTicket.value = 'You Already Booked';
    }
  }

  Future<void> getMovieDetails() async {
    isLoading.value = true;
    Data data = await apiServices.movieDetail(movieId);
    _movieDetails.value = data.data;

    if (!data.isSuccess) {
      Get.snackbar('Error', data.message);
    }

    isLoading.value = false;
  }
}
