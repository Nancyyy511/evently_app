class UserModel {
  String? id;
  String? name;
  String email;
  String password;

  UserModel({this.id, this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"name": name, "id": id, "email": email};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      // password is never stored in Firestore, so it is always empty here
      email: json['email'] as String? ?? '',
      password: '',
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }
}
