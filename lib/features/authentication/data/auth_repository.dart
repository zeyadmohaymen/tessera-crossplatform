import 'dart:convert';

import 'package:tessera/constants/enums.dart';
import 'package:tessera/core/services/networking/networking.dart';
import 'package:tessera/features/authentication/data/user_model.dart';

/// Repository for all authentication services and API calls to the backend server.
class AuthRepository {
  /// Checks if the user already exists in the database, or is a new user.
  ///
  /// Returns [UserState.login] if the user exists, or [UserState.signup] if the user is new.
  static Future<UserState> checkIfUserExists(String email) async {
    final data = {
      'email': email,
    };
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/emailexist', jsonEncode(data));
    if (responseBody['success'] == true) {
      return UserState.login;
    } else {
      return UserState.signup;
    }
  }

  /// Requests backend to sign up the user.
  ///
  /// Returns [true] if the sign up is successful, or [false] if the sign up is unsuccessful.
  static Future<Map> emailAccountSignUp(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/signup', data);
    return responseBody;
  }

  /// Requests backend to log in the user.
  ///
  /// Returns [true] if the log in is successful, or [false] if the log in is unsuccessful.
  static Future<Map> emailAccountLogin(String data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/login', data);
    return responseBody;
  }

  /// Requests backend to send a 'Forgot Password' email to the user.
  ///
  /// Returns [true] if the email is sent successfully, or [false] if the email is not sent.
  static Future<bool> checkForgetPassword(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/forgetPassword', data);
    return responseBody['success'];
  }

  /// Requests backend to reset the password of the user.
  ///
  /// Returns [true] if the password is reset successfully, or [false] if the password is not reset.
  static Future<bool> checkResetPassword(String token, var data) async {
    String url = 'https://www.tessera.social/api/auth/reset-password/$token';
    final responseBody = await NetworkService.getPostApiResponse(url, data);
    return responseBody['success'];
  }

  /// Requests backend to send a verification email to the user.
  ///
  /// Returns [true] if the email is sent successfully, or [false] if the email is not sent.
  static Future<bool> checkEmailVerified(var data) async {
    final responseBody = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/auth/verify/', data);
    return responseBody['success'];
  }

  /// Requests backend to log in the user using a social account (Google or Facebook).
  static Future<Map> socialAccountLogin(String service, UserModel user) async {
    // Data to be sent along with the request
    final data = {
      "firstname": user.username?.split(' ')[0],
      "lastname": user.username?.split(' ')[1],
      "email": user.email,
      "id": user.userId,
    };

    final response = await NetworkService.getPostApiResponse(
        'https://www.tessera.social/api/user/auth/$service/app',
        jsonEncode(data));

    return response;
  }
}
