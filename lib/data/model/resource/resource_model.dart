class ResourcesModel {
  bool? success;
  String? message;
  Data? data;

  ResourcesModel({this.success, this.message, this.data});

  ResourcesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<Resources>? resources;

  Data({this.resources});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources!.add(Resources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (resources != null) {
      data['resources'] = resources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resources {
  int? id;
  String? title;
  String? resourceType;
  String? source;
  dynamic sourceData;
  dynamic description;
  dynamic image;
  int? isFree;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Resources(
      {this.id,
        this.title,
        this.resourceType,
        this.source,
        this.sourceData,
        this.description,
        this.image,
        this.isFree,
        this.orderNo,
        this.status,
        this.createdAt,
        this.updatedAt});

  Resources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    resourceType = json['resource_type'];
    source = json['source'];
    sourceData = json['source_data'];
    description = json['description'];
    image = json['image'];
    isFree = json['is_free'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['resource_type'] = resourceType;
    data['source'] = source;
    data['source_data'] = sourceData;
    data['description'] = description;
    data['image'] = image;
    data['is_free'] = isFree;
    data['order_no'] = orderNo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}