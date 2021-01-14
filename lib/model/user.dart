// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.user,
    this.token,
  });

  UserClass user;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["User"]),
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "User": user.toJson(),
        "Token": token,
      };
}

class UserClass {
  UserClass({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.avatar,
  });

  String id;
  String firstname;
  String lastname;
  String username;
  String email;
  String avatar;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "avatar": avatar,
      };
}
