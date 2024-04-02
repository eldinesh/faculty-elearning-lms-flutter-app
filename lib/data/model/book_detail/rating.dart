class Rating {
  int? totalReview;
  String? avgRating;
  int? oneStar;
  int? twoStar;
  int? threeStar;
  int? fourStar;
  int? fiveStar;

  Rating({
    this.totalReview,
    this.avgRating,
    this.oneStar,
    this.twoStar,
    this.threeStar,
    this.fourStar,
    this.fiveStar,
  });

  factory Rating.fromJson(Map<String, Object?> json) => Rating(
        totalReview: json['total_review'] as int?,
        avgRating: json['avg_rating'] as String?,
        oneStar: json['one_star'] as int?,
        twoStar: json['two_star'] as int?,
        threeStar: json['three_star'] as int?,
        fourStar: json['four_star'] as int?,
        fiveStar: json['five_star'] as int?,
      );

  Map<String, Object?> toJson() => {
        'total_review': totalReview,
        'avg_rating': avgRating,
        'one_star': oneStar,
        'two_star': twoStar,
        'three_star': threeStar,
        'four_star': fourStar,
        'five_star': fiveStar,
      };
}
