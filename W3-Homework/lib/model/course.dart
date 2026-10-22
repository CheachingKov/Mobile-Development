class Course {
  final String id;
  final String name;
  final List<String> studentIds = [];
  // final List<Result> results = [];

  Course({required this.id, required this.name});

  void addStudentId(String studentId) {
    studentIds.add(studentId);
  }

  void removeStudentId(String studentId) {
    studentIds.remove(studentId);
  }
}
