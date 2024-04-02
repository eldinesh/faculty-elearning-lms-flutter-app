class Coupon {
  int? id;
  String? image;
  String? title;
  String? code;
  int? discount;
  String? discountType;
  String? endDate;

  Coupon({
    this.id,
    this.image,
    this.title,
    this.code,
    this.discount,
    this.discountType,
    this.endDate,
  });

  factory Coupon.fromJson(Map<String, Object?> json) => Coupon(
        id: json['id'] as int?,
        image: json['image'] as String?,
        title: json['title'] as String?,
        code: json['code'] as String?,
        discount: json['discount'] as int?,
        discountType: json['discount_type'] as String?,
        endDate: json['end_date'] as String?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'image': image,
        'title': title,
        'code': code,
        'discount': discount,
        'discount_type': discountType,
        'end_date': endDate,
      };
}
