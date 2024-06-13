class AppUser {
  AppUser({this.id, this.name});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    name = json['name'].toString();
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
