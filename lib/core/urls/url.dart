class ApiEndPoints {
  static const baseUrl = "http://10.0.2.2:5000";
  static const signup = "/signup";
  static const otp = "/signup-send-otp";
  static const login = "/login";
  static const forgotPassword = "/forget-password";
  static const forgotPasswordOtp = "/forget-send-otp";
  static const createpost = "/createpost";
  static const getPosts = "/posts";
  static const search = "/search?query=";
  static const currentUser = "/me";
  static const delete = "/post/";
  static const like = "/post/like/";
  static const unlike = "/post/unlike/";
  static const addcomment = "/post/comment/add";
  static const deletecomment = "/post/comment/delete";
  static const savePost = "/save-post/";
  static const unSavePost = "/unsave-post/";
  static const savedPost = "/saved-post";
  static const getUser = "/user/";
  static const follow = "/follow";
  static const unFollow = "/unfollow";
  static const editProfile = "/profile/edit";

  // static const coludinaryUrl = "http://api.cloudinary.com/v1_1/"
}
