import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? id;
  String? name;
  String? email;
  String? password;

  UsersModel({this.id, this.name, this.email, this.password});

  factory UsersModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UsersModel(
      id: doc.id,
      email: data['email'] ?? 'no email',
      password: data['password'] ?? 'no password',
      name: data['name'] ?? 'no name',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'password': password, 'name': name};
  }
}
