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

  Quiz({
    this.id,
    this.sectionId,
    this.title,
    this.slug,
    this.duration,
    this.totalMarks,
    this.passMarks,
    this.certificateIncluded,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    sectionId = json['section_id']?.toInt();
    title = json['title']?.toString();
    slug = json['slug']?.toString();
    duration = json['duration']?.toInt();
    totalMarks = json['total_marks']?.toInt();
    passMarks = json['pass_marks']?.toInt();
    certificateIncluded = json['certificate_included']?.toInt();
    status = json['status']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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
