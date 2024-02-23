class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const Todo(
      {required this.id,
      required this.title,
      required this.description,
      this.isCompleted = false});

  Todo copyWith(
      {String? id, String? title, String? description, bool? isCompleted}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted);
  }
}
