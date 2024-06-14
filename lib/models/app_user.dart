import 'models.dart';

class AppUser {
  AppUser({this.id, this.name, this.workingProjects});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    name = json['name'].toString();
    workingProjects = (json['working_projects'] as List<dynamic>).map((dynamic e) => Project.fromJson(e as Map<String, dynamic>)).toList();
  }

  int? id;
  String? name;
  List<Project>? workingProjects;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['working_projects'] = List<dynamic>.from(workingProjects!.map((Project x) => x.toJson()));
    return data;
  }
}
