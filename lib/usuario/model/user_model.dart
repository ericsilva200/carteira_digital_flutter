import 'dart:convert';

class User {
  String? id; 
  String? name;
  String? mail;
  String? password;
  bool? keepOn;

  User({this.id,this.name, this.mail, this.password, this.keepOn});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mail = json['mail'];
    password = json['password'];
    keepOn = json['keepOn'];
  }

  static User fromJsonString(String json) {
    final Map<String, dynamic> parsedJson = jsonDecode(json);
    return User(
        id: parsedJson['id'],
        name: parsedJson['name'],
        mail: parsedJson['mail'],
        password: parsedJson['password'],
        keepOn: parsedJson['keepOn'],
    );
  }

  String toJsonString() {

    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mail'] = mail;
    data['password'] = password;
    data['keepOn'] = keepOn;
    return data;
  }

  @override
  String toString() {
    return "Name: $name\nEmail: $mail\nPassword: $password";
  }
}
