class Option {
  String answer = '';
  int isCorrect = 0;

  Option({required this.answer,required this.isCorrect});

  Option.fromJson(Map<String, dynamic> json) {
    answer = json['answer'] ;
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['is_correct'] = isCorrect;
    return data;
  }
}
