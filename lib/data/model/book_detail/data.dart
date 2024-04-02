import '../common/book.dart';
import '../common/organization.dart';
import 'instructor.dart';
import '../book_detail/rating.dart';
import '../book_detail/summary.dart';

class BookDetailData {
  int? id;
  String? title;
  String? description;
  String? thumbnail;
  String? price;
  bool? isDiscounted;
  String? discountType;
  String? discountedPrice;
  bool? isWishlistAdded;
  BookInstructor? instructor;
  List<BookModel>? relatedBooks;
  Organization? organization;
  String? contactNo;
  int? totalReviews;
  String? avgRatings;
  bool? isReviewed;
  bool? canReview;
  bool? isEbook;
  int? currentStock;
  Rating? rating;
  Summary? summary;

  BookDetailData({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.price,
    this.isDiscounted,
    this.discountType,
    this.discountedPrice,
    this.isWishlistAdded,
    this.instructor,
    this.relatedBooks,
    this.organization,
    this.contactNo,
    this.totalReviews,
    this.avgRatings,
    this.isReviewed,
    this.canReview,
    this.isEbook,
    this.currentStock,
    this.rating,
    this.summary,
  });

  factory BookDetailData.fromJson(Map<String, Object?> json) => BookDetailData(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        thumbnail: json['thumbnail'] as String?,
        price: json['price'] as String?,
        isDiscounted: json['is_discounted'] as bool?,
        discountType: json['discount_type'] as String?,
        discountedPrice: json['discounted_price'] as String?,
        isWishlistAdded: json['is_wishlist_added'] as bool?,
        instructor: json['instructor'] == null
            ? null
            : BookInstructor.fromJson(
                json['instructor']! as Map<String, Object?>),
        relatedBooks: (json['related_books'] as List<dynamic>?)
            ?.map((e) => BookModel.fromJson(e as Map<String, Object?>))
            .toList(),
        organization: json['organization'] == null
            ? null
            : Organization.fromJson(
                json['organization']! as Map<String, Object?>),
        contactNo: json['contact_no'] as String?,
        totalReviews: json['total_reviews'] as int?,
        avgRatings: json['avg_ratings'] as String?,
        isReviewed: json['is_reviewed'] as bool?,
        canReview: json['can_review'] as bool?,
        isEbook: json['is_ebook'] as bool?,
        currentStock: json['current_stock'] as int?,
        rating: json['rating_counts'] != null
            ? Rating.fromJson(json['rating_counts'] as Map<String, Object?>)
            : null,
        summary: json['summary'] != null
            ? Summary.fromJson(json['summary'] as Map<String, Object?>)
            : null,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'thumbnail': thumbnail,
        'price': price,
        'is_discounted': isDiscounted,
        'discount_type': discountType,
        'discounted_price': discountedPrice,
        'is_wishlist_added': isWishlistAdded,
        'instructor': instructor?.toJson(),
        'related_books': relatedBooks?.map((e) => e.toJson()).toList(),
        'organization': organization?.toJson(),
        'contact_no': contactNo,
        'total_reviews': totalReviews,
        'avg_ratings': avgRatings,
        'is_reviewed': isReviewed,
        'can_review': canReview,
        'is_ebook': isEbook,
        'current_stock': currentStock,
        'rating_counts': rating?.toJson(),
        'summary' : summary?.toJson(),
      };
}
