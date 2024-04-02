import 'order_history.dart';

class Data {
	List<OrderHistory>? orderHistories;

	Data({this.orderHistories});

	factory Data.fromJson(Map<String, Object?> json) => Data(
				orderHistories: (json['order_histories'] as List<dynamic>?)
						?.map((e) => OrderHistory.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'order_histories': orderHistories?.map((e) => e.toJson()).toList(),
			};
}
