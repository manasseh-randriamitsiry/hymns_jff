class User {
  final String email;

  User({required this.email});

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      email: data['email'],
    );
  }
}
