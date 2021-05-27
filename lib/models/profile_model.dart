import 'package:travel_app/api/api_keys.dart';

class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  ProfileModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProfileModel(
      lastName: json[ApiKey.lastName],
      firstName: json[ApiKey.firstName],
      email: json[ApiKey.email],
    );
  }
}
