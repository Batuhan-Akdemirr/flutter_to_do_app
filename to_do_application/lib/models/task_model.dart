// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final String id;
  final String name;
  final DateTime createdAt;
  final bool isCompleted;
  Task({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isCompleted,
  });
  
}
