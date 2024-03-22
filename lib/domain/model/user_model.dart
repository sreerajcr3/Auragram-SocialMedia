class User {
  final String? username;
  final String? fullname;
  final String? email;
  final String? profilePic;
  final String? password;
  final String? accountType;
  final int? phoneNo;
  final String? otp;

  User({
    this.username,
     this.fullname,
     this.email,
     this.profilePic,
     this.password,
     this.accountType,
     this.phoneNo,
     this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      profilePic: json['profile_picture'],
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
      'profile_picture': profilePic,
      'password': password,
      'accountType': accountType,
      'phoneNo': phoneNo,
      'otp': otp,
    };
  }
}
