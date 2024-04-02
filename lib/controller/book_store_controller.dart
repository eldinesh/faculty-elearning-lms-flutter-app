import 'package:get/get.dart';
import 'package:lms_user_app/data/model/book_store_model/book_store_model.dart';

import '../components/custom_snackbar.dart';
import '../data/model/book_store_model/all_books/all_books.dart';
import '../data/model/common/book.dart';
import '../repository/book_store_repository.dart';

class BookStoreController extends GetxController {
  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;
  bool isBookStoreDataLoading = false;
  BookStoreModel? _bookStoreModel;
  BookStoreModel? get bookStoreModel => _bookStoreModel;

  //latest books
  int currentPage = 1;
  bool isLoadingMoreData = false;
  final List<BookModel> _bookList = [];
  List<BookModel> get bookList => _bookList;

  @override
  void onInit() {
    getBookStoreData();
    getLatestBooks();
    super.onInit();
  }

  Future<void> getLatestBooks() async {
    final response =
        await BookStoreRepository(apiClient: Get.find()).getLatestBooks(currentPage);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        AllBooks allBooks = AllBooks.fromJson(response.body);
        _bookList.addAll(allBooks.data!.books!);
        if (allBooks.data!.books!.isNotEmpty) {
          currentPage++;
        }
      }
    }
    update();
  }

  Future<void> paginate() async {
    isLoadingMoreData = true;
    update();
    await getLatestBooks();
    isLoadingMoreData = false;
    update();
  }

  Future<void> getBookStoreData() async {
    isBookStoreDataLoading = true;
    update();
    final response =
        await BookStoreRepository(apiClient: Get.find()).getBookStoreData();
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        BookStoreModel model = BookStoreModel.fromJson(response.body);
        _bookStoreModel = model;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body['message'] ?? '');
    }
    isBookStoreDataLoading = false;
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }
}
