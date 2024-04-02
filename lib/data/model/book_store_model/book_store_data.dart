import '../common/book.dart';
import '../common/category.dart';
import 'slider.dart';

class BookStoreData {
  String? sectionType;
  List<Slider>? sliders;
  List<BookModel>? trendingBooks;
  List<Category>? categories;
  List<BookModel>? recentPublished;
  List<BookModel>? popularBooks;
  List<BookModel>? highRatedBooks;

  BookStoreData({
    this.sectionType,
    this.sliders,
    this.trendingBooks,
    this.categories,
    this.recentPublished,
    this.popularBooks,
    this.highRatedBooks,
  });

  factory BookStoreData.fromJson(Map<String, Object?> json) => BookStoreData(
        sectionType: json['section_type'] as String?,
        sliders: (json['sliders'] as List<dynamic>?)
            ?.map((e) => Slider.fromJson(e as Map<String, Object?>))
            .toList(),
        trendingBooks: (json['trending_books'] as List<dynamic>?)
            ?.map((e) => BookModel.fromJson(e as Map<String, Object?>))
            .toList(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, Object?>))
            .toList(),
        recentPublished: (json['recent_published'] as List<dynamic>?)
            ?.map((e) => BookModel.fromJson(e as Map<String, Object?>))
            .toList(),
        popularBooks: (json['popular_books'] as List<dynamic>?)
            ?.map((e) => BookModel.fromJson(e as Map<String, Object?>))
            .toList(),
        highRatedBooks: (json['high_rated_books'] as List<dynamic>?)
            ?.map((e) => BookModel.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'section_type': sectionType,
        'sliders': sliders?.map((e) => e.toJson()).toList(),
        'trending_books': trendingBooks?.map((e) => e.toJson()).toList(),
        'categories': categories?.map((e) => e.toJson()).toList(),
        'recent_published': recentPublished?.map((e) => e.toJson()).toList(),
        'popular_books': popularBooks?.map((e) => e.toJson()).toList(),
        'high_rated_books': highRatedBooks?.map((e) => e.toJson()).toList(),
      };
}
