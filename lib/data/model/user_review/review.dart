import 'user.dart';

class Review {
	int? id;
	String? rating;
	String? date;
	String? comment;
	User? user;

	Review({this.id, this.rating, this.date, this.comment, this.user});

	factory Review.fromJson(Map<String, Object?> json) => Review(
				id: json['id'] as int?,
				rating: json['rating'] as String?,
				date: json['date'] as String?,
				comment: json['comment'] as String?,
				user: json['user'] == null
						? null
						: User.fromJson(json['user']! as Map<String, Object?>),
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'rating': rating,
				'date': date,
				'comment': comment,
				'user': user?.toJson(),
			};
}
