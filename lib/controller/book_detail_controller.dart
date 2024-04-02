import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/data/model/book_store_model/all_books/all_books.dart';
import 'package:lms_user_app/data/model/common/book.dart';
import 'package:lms_user_app/data/model/user_review/user_review.dart';
import 'package:lms_user_app/repository/book_detail_repository.dart';

import '../data/model/book_detail/book_detail.dart';
import '../data/model/book_detail/data.dart';
import '../data/model/user_review/review.dart';

class BookDetailController extends GetxController implements GetxService{
  bool isLoading = false;
  BookDetailData? _bookDetail;
  BookDetailData? get bookDetail => _bookDetail;

  //reviews
  int pageNumber = 1;
  List<Review> reviews = [];
  bool isLoadingReviewsMore = false;
  bool hasMoreReviewData = true;

  //related books
  List<BookModel> relatedbooks = [];
  bool isRelatedBooksLoadingData = false;
  int relatedBooksPageNumber = 1;

  //write review
  bool isWriteReviewLoading = false;
  double ratingValue = 0.0;
  final messageController = TextEditingController();

  @override
  void onInit() {
    getRelatedBooks();
    super.onInit();
  }

  Future<void> getBookDetail(int id) async {
    isLoading = true;
    update();
    final response = await BookDetailRepository(Get.find()).getBookDetail(id);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true && response.body['data'] != '[]') {
        BookDetail book = BookDetail.fromJson(response.body);
        _bookDetail = book.data;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body['message'] ?? 'something_wrong'.tr);
    }
    isLoading = false;
    update();
  }

  Future<void> getReviews(int id) async {
    final response =
        await BookDetailRepository(Get.find()).getReviews(id, pageNumber);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        UserReview review = UserReview.fromJson(response.body);
        reviews.addAll(review.data!.reviews!);
        if (review.data!.reviews!.isNotEmpty) {
          pageNumber++;
        } else {
          hasMoreReviewData = false;
        }
      }
    }
    update();
  }

  Future<void> writeReview(
      {required int id,
      required String comment,
      required double rating}) async {
    FocusScope.of(Get.context!).unfocus();
    isWriteReviewLoading = true;
    update(['_dialog']);
    final body = {
      'id': id,
      'type': 'book',
      'rating': rating,
      'comment': comment
    };
    final response = await BookDetailRepository(Get.find()).writeReview(body);
    getBookDetail(id);
    messageController.clear();
    Get.back();
    if (response != null && response.statusCode == 200) {
      customSnackBar(response.body['message'], isError: false);
    } else {
      customSnackBar(response?.body['message'] ?? "something_wrong".tr);
    }
    isWriteReviewLoading = false;
    update(['_dialog']);
  }

  void updateRatingValue(double value) {
    ratingValue = value;
    update(['_dialog']);
  }

  Future<void> paginateReviews(int id) async {
    isLoadingReviewsMore == true;
    update();
    await getReviews(id);
    isLoadingReviewsMore == false;
    update();
  }

  //related books
  Future<void> getRelatedBooks() async {
    isRelatedBooksLoadingData = true;
    update();
    final response = await BookDetailRepository(Get.find())
        .getRelatedBooks(relatedBooksPageNumber);

    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        AllBooks allBooks = AllBooks.fromJson(response.body);
        if (allBooks.data!.books != null) {
          relatedbooks.addAll(allBooks.data!.books!);
          if (allBooks.data!.books!.isNotEmpty) {
            relatedBooksPageNumber++;
          }
        }
      }
    }
    isRelatedBooksLoadingData = false;
    update();
  }
}
