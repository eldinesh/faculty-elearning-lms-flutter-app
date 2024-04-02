class BookModel {
	int? id;
	String? thumbnail;
	String? title;
	String? price;
	bool? isFree;
	String? totalRating;
	bool? isDiscounted;
	String? discountType;
	String? discountedPrice;
	String? publishedBy;

	BookModel({
		this.id, 
		this.thumbnail, 
		this.title, 
		this.price, 
		this.isFree, 
		this.totalRating, 
		this.isDiscounted, 
		this.discountType, 
		this.discountedPrice, 
		this.publishedBy, 
	});

	factory BookModel.fromJson(Map<String, Object?> json) {
		return BookModel(
			id: json['id'] as int?,
			thumbnail: json['thumbnail'] as String?,
			title: json['title'] as String?,
			price: json['price'] as String?,
			isFree: json['is_free'] as bool?,
			totalRating: json['total_rating'] as String?,
			isDiscounted: json['is_discounted'] as bool?,
			discountType: json['discount_type'] as String?,
			discountedPrice: json['discounted_price'] as String?,
			publishedBy: json['published_by'] as String?,
		);
	}



	Map<String, Object?> toJson() => {
				'id': id,
				'thumbnail': thumbnail,
				'title': title,
				'price': price,
				'is_free': isFree,
				'total_rating': totalRating,
				'is_discounted': isDiscounted,
				'discount_type': discountType,
				'discounted_price': discountedPrice,
				'published_by': publishedBy,
			};
}
