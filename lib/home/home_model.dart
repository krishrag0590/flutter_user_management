class UserModel {
  String? name;
  String? age;
  int? id;

  UserModel({this.name, this.age, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'].toString();
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['age'] = age;
    data['id'] = id;
    return data;
  }
}
