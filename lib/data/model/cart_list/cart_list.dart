import 'cart_list_data.dart';

class CartList {
  bool? success;
  String? message;
  CartListData? data;

  CartList({this.success, this.message, this.data});

  factory CartList.fromJson(Map<String, Object?> json) => CartList(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : CartListData.fromJson(json['data']! as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}
