class UserData {
  final String email;
  final String username;
  final String id;
  final bool hasPassword;
  final String phone;
  final String address;

  UserData({
    required this.email,
    required this.username,
    required this.id,
    this.hasPassword = false,
    this.phone = '',
    this.address = '',
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      id: json['id'] ?? '',
      hasPassword: json['hasPassword'] ?? false,
      phone: json['no_hp'] ?? '', // <- key harus sama
      address: json['alamat'] ?? '', // <- key harus sama
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
