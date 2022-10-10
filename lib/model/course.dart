import 'package:flutter/material.dart';

class Course {
  String courseName;
  String courseStartTime;
  String courseEndTime;
  TimeOfDay courseStart = TimeOfDay(hour: 1, minute: 1), courseEnd = TimeOfDay(hour: 1, minute: 1);

  Course(this.courseName, this.courseStartTime, this.courseEndTime,) {
    int courseStartHour = int.parse(courseStartTime.substring(0, courseStartTime.indexOf(":")));
    courseStartHour = courseStartHour <= 6 ? courseStartHour + 12 : courseStartHour;
    int courseEndHour = int.parse(courseEndTime.substring(0, courseEndTime.indexOf(":")));
    courseEndHour = courseEndHour <= 6 ? courseEndHour + 12 : courseEndHour;

    courseStart = TimeOfDay(hour: courseStartHour, minute: int.parse(courseStartTime.substring(courseStartTime.indexOf(":") + 1)));
    courseEnd = TimeOfDay(hour: courseEndHour, minute: int.parse(courseEndTime.substring(courseEndTime.indexOf(":") + 1)));
  }
  
}
