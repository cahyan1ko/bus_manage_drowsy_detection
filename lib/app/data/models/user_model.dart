class UserData {
  final String email;
  final String username;
  final String id;
  final bool hasPassword;

  UserData({
    required this.email,
    required this.username,
    required this.id,
    this.hasPassword = false,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      id: json['id'] ?? '',
      hasPassword: json['has_password'] ?? false,
    );
  }
}

class UserModel {
  final String token;
  final UserData user;
  final String errorMessage;

  UserModel({
    required this.token,
    required this.user,
    this.errorMessage = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      user: UserData.fromJson(json['user'] ?? {}),
    );
  }

  factory UserModel.error(String message) {
    return UserModel(
      token: '',
      user: UserData(email: '', username: '', id: ''),
      errorMessage: message,
    );
  }
}
