class Calculations {
	String? subTotal;
	String? discount;
	String? couponDiscount;
	String? tax;
	String? totalPayable;

	Calculations({
		this.subTotal, 
		this.discount, 
		this.couponDiscount, 
		this.tax, 
		this.totalPayable, 
	});

	factory Calculations.fromJson(Map<String, Object?> json) => Calculations(
				subTotal: json['sub_total'] as String?,
				discount: json['discount'] as String?,
				couponDiscount: json['coupon_discount'] as String?,
				tax: json['tax'] as String?,
				totalPayable: json['total_payable'] as String?,
			);

	Map<String, Object?> toJson() => {
				'sub_total': subTotal,
				'discount': discount,
				'coupon_discount': couponDiscount,
				'tax': tax,
				'total_payable': totalPayable,
			};
}
