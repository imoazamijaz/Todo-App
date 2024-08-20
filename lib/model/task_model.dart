class Task {
  int? id;
  String title;
  String description;
  String date;
  String time;
  int isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = 0,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: json['date'],
    time: json['time'],
    isCompleted: json['isCompleted'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'time': time,
    'isCompleted': isCompleted,
  };
}
