class UserModel {
  final String token;
  final String errorMessage;

  UserModel({required this.token, this.errorMessage = ''});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
    );
  }

  factory UserModel.error(String message) {
    return UserModel(
      token: '',
      errorMessage: message,
    );
  }
}
