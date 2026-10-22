import '../model/course.dart';
import '../model/course_result.dart';
import '../model/student.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<Result> results = [];

  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $studentId already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }
 
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }

    for(Course course in courses){
      course.studentIds.removeWhere((id) => id == studentId);
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  } 

  void addCourse({required String courseId, required String courseName}){
    Course? course = _findCourseOrNull(courseId);
    if(course != null){
      throw Exception("The course $course already exists");
    }
    courses.add(Course(id: courseId, name: courseName));
  }

  void removeCourse({required String courseId}){
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception("Course $courseId not found");
    }

    if(course.studentIds.isNotEmpty){
      throw Exception("Cannot remove course while students are enrolled");
    }
    courses.removeWhere((course) => course.id == courseId);
  }

  void enrollStudent({required String studentId, required String courseId}){
    if (_findStudentOrNull(studentId) == null) {
      throw Exception("Student $studentId not found");
    }
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception("Course $courseId not found");
    }
    if(course.studentIds.contains(studentId)){
      throw Exception("Student $studentId is already exists in $courseId");
    }
    course.studentIds.add(studentId);
  }

  void discardStudentFromCourse({required String studentId, required String courseId}) {
    if (_findStudentOrNull(studentId) == null) {
      throw Exception("Student $studentId not found");
    }
    final course = _findCourseOrNull(courseId);

    if (course == null) {
      throw Exception("Course $courseId not found");
    }

    if (!course.studentIds.contains(studentId)) {
      throw Exception("Student $studentId is not enrolled in course $courseId");
    }

    course.studentIds.remove(studentId);

    results.removeWhere(
      (result) =>
          result.studentId == studentId &&
          result.courseId == courseId,
    );
  }

  Course? _findCourseOrNull(String courseId){
    for(Course c in courses){
      if(c.id == courseId){
        return c;
      }
    }
    return null;
  }

  void addResult({required String studentId, required String courseId, required double score }) {
    if (_findStudentOrNull(studentId) == null) {
      throw Exception("Student $studentId not found");
    }

    final course = _findCourseOrNull(courseId);

    if (course == null) {
      throw Exception("Course $courseId not found");
    }

    if (!course.studentIds.contains(studentId)) {
      throw Exception("Student $studentId is not enrolled in course $courseId");
    }

    if (!score.isFinite || score < 0 || score > 100) {
      throw Exception("Score must be between 0 and 100");
    }

    if (_findResultOrNull(studentId, courseId) != null) {
      throw Exception("Result already exists for student $studentId in course $courseId");
    }

    final result = Result(studentId: studentId, courseId: courseId, score: score);
    results.add(result);
  }

  void removeResult({required String studentId, required String courseId}) {
    final result = _findResultOrNull(studentId, courseId);

    if (result == null) {
      throw Exception("Result not found for student $studentId in course $courseId");
    }
    results.remove(result);
  }

  Result? _findResultOrNull(String studentId, String courseId) {
    for (Result r in results) {
      if (r.studentId == studentId && r.courseId == courseId) {
        return r;
      }
    }
    return null;
  }

}
