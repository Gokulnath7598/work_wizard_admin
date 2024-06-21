import 'models.dart';

class ProjectTask {

  ProjectTask({
    this.id,
    this.userID,
    this.task,
    this.status,
    this.time,
    this.createdTime,
    this.user,
    this.project
  });

  factory ProjectTask.fromJson(Map<String, dynamic>? json) => ProjectTask(
    id: json?['id'] != null ? int.parse(json!['id'].toString()) : null,
    userID: json?['user_id'] != null ? int.parse(json!['user_id'].toString()) : null,
    task: json?['task_description'].toString(),
    status: json?['status'].toString(),
    time: json?['effort'].toString(),
    createdTime: json?['created_time'].toString(),
    user: Employee.fromJson(json?['user'] as Map<String, dynamic>),
    project: Project.fromJson(json?['project'] as Map<String, dynamic>),
  );

  int? id;
  int? userID;
  String? task;
  String? status;
  String? time;
  String? createdTime;
  Employee? user;
  Project? project;

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['user_id'] = userID;
  data['task_description'] = task;
  data['status'] = status;
  data['effort'] = time;
  data['user'] = user;
  data['project'] = project;
  return data;
  }
  }
