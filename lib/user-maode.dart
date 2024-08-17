class UserModel {
  String name;
  String email;
  String phone;
  int age;
  String id;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.age,
      this.id = ""});

  UserModel.fromJason(Map<String, dynamic> jason)
      : this(
          name: jason["name"],
          email: jason["email"],
          phone: jason["phone"],
          id: jason["id"],
          age: jason["age"],
        );

  Map<String, dynamic> toJason() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "id": id,
      "age": age,
    };
  }
}
