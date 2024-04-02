import 'user_data.dart';

class UserModel {
	bool? success;
	String? message;
	UserData? data;

	UserModel({this.success, this.message, this.data});

	factory UserModel.fromJson(Map<String, Object?> json) => UserModel(
				success: json['success'] as bool?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: UserData.fromJson(json['data']! as Map<String, Object?>),
			);

	Map<String, Object?> toJson() => {
				'success': success,
				'message': message,
				'data': data?.toJson(),
			};
}
