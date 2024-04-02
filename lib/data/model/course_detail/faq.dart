class Faq {
	int? id;
	String? question;
	String? answer;

	Faq({this.id, this.question, this.answer});

	factory Faq.fromJson(Map<String, Object?> json) => Faq(
				id: json['id'] as int?,
				question: json['question'] as String?,
				answer: json['answer'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'question': question,
				'answer': answer,
			};
}
