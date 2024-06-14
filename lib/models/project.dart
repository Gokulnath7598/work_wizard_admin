class Project {

  Project({
    this.id,
    this.name,
    this.activeTask,
    this.completedTask,
    this.lastUpdate,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'] != null ? int.parse(json['id'].toString()) : null,
    name: json['name'].toString(),
    activeTask: json['active_task'] != null ? int.parse(json['active_task'].toString()) : null,
    completedTask: json['completed_task'] != null ? int.parse(json['completed_task'].toString()) : null,
    lastUpdate: json['last_update'].toString(),
  );
  int? id;
  String? name;
  int? activeTask;
  int? completedTask;
  String? lastUpdate;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'active_task': activeTask,
    'completed_task': completedTask,
    'last_update': lastUpdate,
  };
}
