class AssignmentModel {
  bool? success;
  String? message;
  Data? data;

  AssignmentModel({this.success, this.message, this.data});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
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
  List<Assignments>? assignments;
  int? dueAssignments;
  int? completeAssignment;
  int? failedAssignment;

  Data(
      {this.assignments,
        this.dueAssignments,
        this.completeAssignment,
        this.failedAssignment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(Assignments.fromJson(v));
      });
    }
    dueAssignments = json['due_assignments'];
    completeAssignment = json['complete_assignment'];
    failedAssignment = json['failed_assignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (assignments != null) {
      data['assignments'] = assignments!.map((v) => v.toJson()).toList();
    }
    data['due_assignments'] = dueAssignments;
    data['complete_assignment'] = completeAssignment;
    data['failed_assignment'] = failedAssignment;
    return data;
  }
}

class Assignments {
  int? id;
  String? title;
  String? description;
  String? deadline;
  int? totalMarks;
  int? passMarks;
  String? createdAt;

  Assignments(
      {this.id,
        this.title,
        this.description,
        this.deadline,
        this.totalMarks,
        this.passMarks,
        this.createdAt});

  Assignments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    deadline = json['deadline'];
    totalMarks = json['total_marks'];
    passMarks = json['pass_marks'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['deadline'] = deadline;
    data['total_marks'] = totalMarks;
    data['pass_marks'] = passMarks;
    data['created_at'] = createdAt;
    return data;
  }
}