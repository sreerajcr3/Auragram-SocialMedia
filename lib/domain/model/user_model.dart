class User {
  final String? username;
   String? id;
  final String? fullname;
  final String? email;
   String? profilePic;
  final String? coverPic;
  final String? password;
  final String? accountType;
  final String? bio;
  final List? following;
  final List? followers;
  final List? posts;
  final int? phoneNo;
  final String? otp;
  final bool? isBlocked;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  User({
    this.username,
    this.id,
    this.fullname,
    this.email,
    this.profilePic,
    this.coverPic,
    this.password,
    this.accountType,
    this.bio,
    this.following,
    this.followers,
    this.posts,
    this.phoneNo,
    this.otp,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      id:json['_id'],
      fullname: json['fullname'],
      email: json['email'],
      profilePic: json['profile_picture'],
      coverPic: json['cover_photo'],
      password: json['password'],
      accountType: json['accountType'],
      bio: json['bio'],
      following: json['following'] != null ? List.from(json['following']) : [],
      followers: json['followers'] != null ? List.from(json['followers']) : [],
      posts: json['posts'] != null ? List.from(json['posts']) : [],
      phoneNo: json['phoneNo'],
      otp: json['otp'],
      isBlocked: json['isBlocked'],
      createdAt:json['createdAt'],
      updatedAt:json['updatedAt'],
      v:json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      '_id':id,
      'fullname': fullname,
      'email': email,
      'profile_picture': profilePic,
      'cover_photo':coverPic,
      'password': password,
      'accountType': accountType,
      'bio': bio,
      'following': following,
      'followers': followers,
      'posts': posts,
      'phoneNo': phoneNo,
      'otp': otp,
      'isBlocked':isBlocked,
      'createdAt':createdAt,
      '__v':v,
    };
  }

  static empty() {}
}
