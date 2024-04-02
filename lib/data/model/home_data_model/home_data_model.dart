import 'home_data.dart';

class HomeDataModel {
  late bool success;
  late String message;
  List<HomeData>? data;

  HomeDataModel({this.success = false, this.message = "", this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeData>[];
      json['data'].forEach((v) {
        data!.add(HomeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
