import 'review.dart';

class ReviewData {
	List<Review>? reviews;

	ReviewData({this.reviews});

	factory ReviewData.fromJson(Map<String, Object?> json) => ReviewData(
				reviews: (json['reviews'] as List<dynamic>?)
						?.map((e) => Review.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'reviews': reviews?.map((e) => e.toJson()).toList(),
			};
}
