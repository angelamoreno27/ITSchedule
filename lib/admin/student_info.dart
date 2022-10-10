class studentInfo {
  final String name;
  final String job;
  final String position;
  final int hours;

  studentInfo(
      {required this.name,
      required this.job,
      required this.hours,
      required this.position});
}

final List<studentInfo> student_Info = [
  studentInfo(name: 'Jose', job: 'Student', hours: 15, position: 'Phones'),
  studentInfo(name: 'Dylan', job: 'Student', hours: 19, position: 'Desktop'),
  studentInfo(name: 'Michael ', job: 'Student', hours: 10, position: 'Walkup'),
  studentInfo(name: "Angela", job: 'Shift Leader', hours: 20, position: 'MASH')
];
