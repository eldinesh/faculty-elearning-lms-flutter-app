import 'data.dart';

class CouponList {
	bool? success;
	String? message;
	Data? data;

	CouponList({this.success, this.message, this.data});

	factory CouponList.fromJson(Map<String, Object?> json) => CouponList(
				success: json['success'] as bool?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data']! as Map<String, Object?>),
			);

	Map<String, Object?> toJson() => {
				'success': success,
				'message': message,
				'data': data?.toJson(),
			};
}
