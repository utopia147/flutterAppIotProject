// To parse this JSON data, do
//
//     final reqLogin = reqLoginFromJson(jsonString);

import 'dart:convert';

ReqLogin reqLoginFromJson(String str) => ReqLogin.fromJson(json.decode(str));

String reqLoginToJson(ReqLogin data) => json.encode(data.toJson());

class ReqLogin {
    String email;
    String password;

    ReqLogin({
        this.email,
        this.password,
    });

    factory ReqLogin.fromJson(Map<String, dynamic> json) => ReqLogin(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}