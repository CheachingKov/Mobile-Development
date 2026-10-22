
import 'package:test/test.dart';
import '../lib/service/lms_system.dart';

void main() {
  late LmsSystem lms;

  setUp(() {
    lms = LmsSystem();
  });

  group('Student tests', () {
    test('Add a student successfully', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );

      expect(lms.students.length, 1);
      expect(lms.students.first.id, 'S001');
      expect(lms.students.first.name, 'Dara');
    });

    test('Cannot add a student with duplicate ID', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );

      expect(
        () => lms.addStudent(
          studentId: 'S001',
          studentName: 'Sokha',
        ),
        throwsException,
      );
    });

    test('Remove a student successfully', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );

      lms.removeStudent(studentId: 'S001');

      expect(lms.students, isEmpty);
    });

    test('Cannot remove a nonexistent student', () {
      expect(
        () => lms.removeStudent(studentId: 'S999'),
        throwsException,
      );
    });
  });

  group('Course tests', () {
    test('Add a course successfully', () {
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      expect(lms.courses.length, 1);
      expect(lms.courses.first.id, 'C001');
    });

    test('Cannot add a course with duplicate ID', () {
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      expect(
        () => lms.addCourse(
          courseId: 'C001',
          courseName: 'Flutter',
        ),
        throwsException,
      );
    });

    test('Remove an empty course successfully', () {
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      lms.removeCourse(courseId: 'C001');

      expect(lms.courses, isEmpty);
    });

    test('Cannot remove a course with enrolled students', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );
      lms.enrollStudent(
        studentId: 'S001',
        courseId: 'C001',
      );

      expect(
        () => lms.removeCourse(courseId: 'C001'),
        throwsException,
      );
    });
  });

  group('Enrollment tests', () {
    test('Enroll a student successfully', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      lms.enrollStudent(
        studentId: 'S001',
        courseId: 'C001',
      );

      expect(
        lms.courses.first.studentIds,
        contains('S001'),
      );
    });

    test('Cannot enroll the same student twice', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      lms.enrollStudent(
        studentId: 'S001',
        courseId: 'C001',
      );

      expect(
        () => lms.enrollStudent(
          studentId: 'S001',
          courseId: 'C001',
        ),
        throwsException,
      );
    });

    test('Cannot enroll a nonexistent student', () {
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      expect(
        () => lms.enrollStudent(
          studentId: 'S999',
          courseId: 'C001',
        ),
        throwsException,
      );
    });
  });

  group('Result tests', () {
    void prepareEnrolledStudent() {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );
      lms.enrollStudent(
        studentId: 'S001',
        courseId: 'C001',
      );
    }

    test('Add a result successfully', () {
      prepareEnrolledStudent();

      lms.addResult(
        studentId: 'S001',
        courseId: 'C001',
        score: 85.0,
      );

      expect(lms.results.length, 1);
      expect(lms.results.first.studentId, 'S001');
      expect(lms.results.first.courseId, 'C001');
      expect(lms.results.first.score, 85.0);
    });

    test('Cannot add a result for a student not enrolled', () {
      lms.addStudent(
        studentId: 'S001',
        studentName: 'Dara',
      );
      lms.addCourse(
        courseId: 'C001',
        courseName: 'Dart Programming',
      );

      expect(
        () => lms.addResult(
          studentId: 'S001',
          courseId: 'C001',
          score: 85.0,
        ),
        throwsException,
      );
    });

    test('Cannot add a duplicate result', () {
      prepareEnrolledStudent();

      lms.addResult(
        studentId: 'S001',
        courseId: 'C001',
        score: 85.0,
      );

      expect(
        () => lms.addResult(
          studentId: 'S001',
          courseId: 'C001',
          score: 90.0,
        ),
        throwsException,
      );
    });

    test('Cannot add a score above 100', () {
      prepareEnrolledStudent();

      expect(
        () => lms.addResult(
          studentId: 'S001',
          courseId: 'C001',
          score: 101.0,
        ),
        throwsException,
      );
    });

    test('Remove a result successfully', () {
      prepareEnrolledStudent();

      lms.addResult(
        studentId: 'S001',
        courseId: 'C001',
        score: 85.0,
      );

      lms.removeResult(
        studentId: 'S001',
        courseId: 'C001',
      );

      expect(lms.results, isEmpty);
    });
  });
}
