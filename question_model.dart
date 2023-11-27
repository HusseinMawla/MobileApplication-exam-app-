class Question {
  final String id; //question id
  final String title; //question title (the question)
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });
  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
