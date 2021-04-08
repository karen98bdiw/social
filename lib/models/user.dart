import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String name;
  String timeZone;
  String firstName;
  String lastname;
  String phone;
  String email;
  String password;
  String id;

  User({
    this.email,
    this.password,
    this.firstName,
    this.lastname,
    this.name,
    this.phone,
    this.timeZone,
    this.id,
  });

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["email"] = this.email;
    data["firstname"] = this.firstName;
    data["lastname"] = this.lastname;
    data["id"] = this.id;
    return data;
  }

  User copyWith({
    String timeZone,
    String name,
    String firstName,
    String lastname,
    String phone,
    String email,
    String password,
    String id,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
