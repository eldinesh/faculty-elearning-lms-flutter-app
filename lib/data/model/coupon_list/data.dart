import 'coupon.dart';

class Data {
	List<Coupon>? coupons;

	Data({this.coupons});

	factory Data.fromJson(Map<String, Object?> json) => Data(
				coupons: (json['coupons'] as List<dynamic>?)
						?.map((e) => Coupon.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'coupons': coupons?.map((e) => e.toJson()).toList(),
			};
}
