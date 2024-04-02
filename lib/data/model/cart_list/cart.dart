class Cart {
  int? id;
  String? thumbnail;
  String? title;
  bool? isFree;
  String? price;
  bool? isDiscounted;
  String? discountType;
  String? discountedPrice;
  String? type;
  bool? couponApplied;
  String? couponCode;
  int? totalLessons;
  int? totalEnrolls;
  int? courseId;

  Cart({
    this.id,
    this.thumbnail,
    this.title,
    this.isFree,
    this.price,
    this.isDiscounted,
    this.discountType,
    this.discountedPrice,
    this.type,
    this.couponApplied,
    this.couponCode,
    this.totalLessons,
    this.totalEnrolls,
    this.courseId
  });

  factory Cart.fromJson(Map<String, Object?> json) => Cart(
        id: json['id'] as int?,
        thumbnail: json['thumbnail'] as String?,
        title: json['title'] as String?,
        isFree: json['is_free'] as bool?,
        price: json['price'] as String?,
        isDiscounted: json['is_discounted'] as bool?,
        discountType: json['discount_type'] as String?,
        discountedPrice: json['discounted_price'] as String?,
        type: json['type'] as String?,
        couponApplied: json['coupon_applied'] as bool?,
        couponCode: json['coupon_code'] as String?,
        totalLessons: json['total_lessons'] as int?,
        totalEnrolls: json['total_enrolls'] as int?,
        courseId: json['course_id'] as int?
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'thumbnail': thumbnail,
        'title': title,
        'is_free': isFree,
        'price': price,
        'is_discounted': isDiscounted,
        'discount_type': discountType,
        'discounted_price': discountedPrice,
        'type': type,
        'coupon_applied': couponApplied,
        'coupon_code': couponCode,
        'total_lessons': totalLessons,
        'total_enrolls': totalEnrolls,
        'course_id' : courseId
      };
}
