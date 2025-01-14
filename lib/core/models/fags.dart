class Faqs {
  int? id;
  String? question;
  String? answer;
  String? status;

  Faqs({
    this.id,
    this.question,
    this.answer,
    this.status,
  });

  factory Faqs.fromJson(dynamic json) => Faqs(
        id: json["id"] as int,
        question: json["question"] as String?,
        answer: json["answer"] as String?,
        status: json["status"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "status": status,
      };
}
