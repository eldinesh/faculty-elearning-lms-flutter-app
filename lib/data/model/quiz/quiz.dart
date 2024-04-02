class Quiz {
  int? id;
  int? sectionId;
  String? title;
  String? slug;
  int? duration;
  int? totalMarks;
  int? passMarks;
  int? certificateIncluded;
  int? status;
  String? createdAt;
  String? updatedAt;

  Quiz(
      {this.id,
      this.sectionId,
      this.title,
      this.slug,
      this.duration,
      this.totalMarks,
      this.passMarks,
      this.certificateIncluded,
      this.status,
      this.createdAt,
      this.updatedAt});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    title = json['title'];
    slug = json['slug'];
    duration = json['duration'];
    totalMarks = json['total_marks'];
    passMarks = json['pass_marks'];
    certificateIncluded = json['certificate_included'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['title'] = title;
    data['slug'] = slug;
    data['duration'] = duration;
    data['total_marks'] = totalMarks;
    data['pass_marks'] = passMarks;
    data['certificate_included'] = certificateIncluded;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
