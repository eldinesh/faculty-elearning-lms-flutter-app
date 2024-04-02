
class MeetingModel {
  bool? success;
  String? message;
  Data? data;

  MeetingModel({this.success, this.message, this.data});

  MeetingModel.fromJson(Map<String, dynamic> json) {
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
  List<MyMeeting>? myMeeting;

  Data({this.myMeeting});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_meeting'] != null) {
      myMeeting = <MyMeeting>[];
      json['my_meeting'].forEach((v) {
        myMeeting!.add(MyMeeting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (myMeeting != null) {
      data['my_meeting'] = myMeeting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyMeeting {
  int? id;
  String? title;
  String? classDate;
  String? meetingMethod;
  String? description;
  String? meetingLink;
  String? meetingId;
  dynamic endAt;
  dynamic startAt;
  int? isFree;

  MyMeeting(
      {this.id,
        this.title,
        this.classDate,
        this.meetingMethod,
        this.description,
        this.meetingLink,
        this.meetingId,
        this.endAt,
        this.startAt,
        this.isFree});

  MyMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    classDate = json['class_date'];
    meetingMethod = json['meeting_method'];
    description = json['description'];
    meetingLink = json['meeting_link'];
    meetingId = json['meeting_id'];
    endAt = json['end_at'];
    startAt = json['start_at'];
    isFree = json['is_free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['class_date'] = classDate;
    data['meeting_method'] = meetingMethod;
    data['description'] = description;
    data['meeting_link'] = meetingLink;
    data['meeting_id'] = meetingId;
    data['end_at'] = endAt;
    data['start_at'] = startAt;
    data['is_free'] = isFree;
    return data;
  }
}