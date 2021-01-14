import 'dart:convert';

FetchUser fetchUserFromJson(String str) => FetchUser.fromJson(json.decode(str));

String fetchUserToJson(FetchUser data) => json.encode(data.toJson());

class FetchUser {
    FetchUser({
        this.id,
        this.email,
        this.username,
        this.password,
        this.firstname,
        this.lastname,
    });

    String id;
    String email;
    String username;
    String password;
    String firstname;
    String lastname;

    factory FetchUser.fromJson(Map<String, dynamic> json) => FetchUser(
        id: json["_id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "username": username,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
    };
}
