class Todo {
  final String? id;
  String title;
  String description;
  String createdTime;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Map<String, String> toJson() {
    return <String, String>{
      'id': id.toString(),
      'title': title.toString(),
      'description': description.toString(),
      'created_time': createdTime.toString(),
    };
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdTime: map['created_time'] as String,
    );
  }
}
