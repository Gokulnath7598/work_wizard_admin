class Employee {

  Employee({
    this.id,
    this.name,
    this.email,
    this.activeTask,
    this.completedTask,
    this.lastUpdate,
  });

  factory Employee.fromJson(Map<String, dynamic>? json) => Employee(
    id: json?['id'] != null ? int.parse(json!['id'].toString()) : null,
    name: json?['name'].toString(),
    email: json?['email'].toString(),
    activeTask: json?['active_task'] != null ? int.parse(json!['active_task'].toString()) : null,
    completedTask: json?['completed_task'] != null ? int.parse(json!['completed_task'].toString()) : null,
    lastUpdate: json?['last_update'].toString(),
  );

  int? id;
  String? name;
  String? email;
  int? activeTask;
  int? completedTask;
  String? lastUpdate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['active_task'] = activeTask;
    data['completed_task'] = completedTask;
    data['last_update'] = lastUpdate;
    return data;
  }
}
