class User {
  final String username;
  final String fullname;
  final String email;
  final String password;
  final String accountType;
  final int phoneNo;
  final String otp;

  User({
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.accountType,
    required this.phoneNo,
    required this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      password: json['password'],
      accountType: json['accountType'],
      phoneNo: json['phoneNo'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullname': fullname,
      'email': email,
      'password': password,
      'accountType': accountType,
      'phoneNo': phoneNo,
      'otp': otp,
    };
  }
}
