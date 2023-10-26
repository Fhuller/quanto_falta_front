class User {
  String name;
  String email;
  String pwd;
  DateTime date;

  User(
      {required this.name,
      required this.email,
      required this.pwd,
      required this.date});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        name: jsonData['name'],
        email: jsonData['email'],
        pwd: jsonData['pwd'],
        date: jsonData['date']);
  }
}
