class OnBoardModel {
  bool? success;
  String? message;
  OnBoardContent? data;

  OnBoardModel({this.success, this.message, this.data});

  OnBoardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? OnBoardContent.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OnBoardContent {
  List<OnBoardData>? onBoards;

  OnBoardContent({this.onBoards});

  OnBoardContent.fromJson(Map<String, dynamic> json) {
    if (json['on_boards'] != null) {
      onBoards = <OnBoardData>[];
      json['on_boards'].forEach((v) {
        onBoards!.add(OnBoardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (onBoards != null) {
      data['on_boards'] = onBoards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnBoardData {
  int? id;
  String? title;
  String? description;
  String? image;

  OnBoardData({this.id, this.title, this.description, this.image});

  OnBoardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}