import 'models.dart';

class Task {

  Task({
    this.id,
    this.task,
    this.status,
    this.time,
    this.createdTime,
    this.employee,
    this.project
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] != null ? int.parse(json['id'].toString()) : null,
    task: json['task'].toString(),
    status: json['status'].toString(),
    time: json['time'].toString(),
    createdTime: json['created_time'].toString(),
    employee: Employee.fromJson(json['employee'] as Map<String, dynamic>),
    project: Project.fromJson(json['project'] as Map<String, dynamic>),
  );
  int? id;
  String? task;
  String? status;
  String? time;
  String? createdTime;
  Employee? employee;
  Project? project;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'task': task,
    'status': status,
    'time': time,
    'created_time': createdTime,
    'employee': employee,
    'project': project
  };
}
