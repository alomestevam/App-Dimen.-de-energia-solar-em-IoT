class User {
  final String username;
  final String password;

  User(this.username, this.password);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'],
      json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
