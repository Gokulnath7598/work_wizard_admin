class Project {

  Project({
    this.id,
    this.projectName,
    this.activeTask,
    this.completedTask,
    this.lastUpdate,
  });

  factory Project.fromJson(Map<String, dynamic>? json) => Project(
    id: json?['id'] != null ? int.parse(json!['id'].toString()) : null,
    projectName: json?['project_name'].toString(),
    activeTask: json?['active_task'] != null ? int.parse(json!['active_task'].toString()) : null,
    completedTask: json?['completed_task'] != null ? int.parse(json!['completed_task'].toString()) : null,
    lastUpdate: json?['last_update'].toString(),
  );
  int? id;
  String? projectName;
  int? activeTask;
  int? completedTask;
  String? lastUpdate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['active_task'] = activeTask;
    data['completed_task'] = completedTask;
    data['last_update'] = lastUpdate;
    return data;
  }
}
