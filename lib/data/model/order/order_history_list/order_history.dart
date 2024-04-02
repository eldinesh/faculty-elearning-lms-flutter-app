class OrderHistory {
	int? id;
	String? paymentType;
	String? title;
	String? invoiceLink;
	String? amount;
	String? createdAt;

	OrderHistory({
		this.id, 
		this.paymentType, 
		this.title, 
		this.invoiceLink, 
		this.amount, 
		this.createdAt, 
	});

	factory OrderHistory.fromJson(Map<String, Object?> json) => OrderHistory(
				id: json['id'] as int?,
				paymentType: json['payment_type'] as String?,
				title: json['title'] as String?,
				invoiceLink: json['invoice_link'] as String?,
				amount: json['amount'] as String?,
				createdAt: json['created_at'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'payment_type': paymentType,
				'title': title,
				'invoice_link': invoiceLink,
				'amount': amount,
				'created_at': createdAt,
			};
}
