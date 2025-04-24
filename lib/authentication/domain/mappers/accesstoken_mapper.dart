import 'package:batt_auth/authentication/domain/domain.dart';
import 'package:dio/dio.dart';

extension ToAccessToken on Response {
  Accesstoken toAccessToken() {
    return Accesstoken(
      accessToken: data["access_token"],
      expiresIn: DateTime.now().add(
          authServiceDurationFrom(data["expires_in"]) ??
              const Duration(seconds: 0)),
      refreshExpiresIn: DateTime.now().add(
          authServiceDurationFrom(data["refresh_expires_in"]) ??
              const Duration(seconds: 0)),
      refreshToken: data["refresh_token"],
      tokenType: data["token_type"],
      idToken: data["id_token"],
      notBeforePolicy: authServiceDateTimeFrom(data["not-before-policy"]),
      sessionState: data["session_state"],
      scope: data["scope"],
    );
  }

  DateTime? authServiceDateTimeFrom(dynamic data) {
    if (data is int) {
      return DateTime.fromMillisecondsSinceEpoch((data) * 1000);
    }
    return null;
  }

  Duration? authServiceDurationFrom(dynamic data) {
    if (data is int) {
      return Duration(seconds: data);
    }
    return null;
  }
}

extension AccessTokenMapper on Accesstoken {
  Map<String, String> toMap() {
    return {
      "accessToken": accessToken ?? "",
      "expiresIn": expiresIn != null ? expiresIn!.toEpochString() : "",
      "refreshExpiresIn":
          refreshExpiresIn != null ? refreshExpiresIn!.toEpochString() : "",
      "refreshToken": refreshToken ?? "",
      "tokenType": tokenType ?? "",
      "idToken": idToken ?? "",
      "notBeforePolicy":
          notBeforePolicy != null ? notBeforePolicy!.toEpochString() : "",
      "sessionState": sessionState ?? "",
      "scope": scope ?? ""
    };
  }
}

extension ToToken on Map<String, String> {
  Accesstoken toAccessToken() {
    return Accesstoken(
        accessToken: this["accessToken"],
        expiresIn: DateTime.fromMillisecondsSinceEpoch(
            (int.parse(this["expiresIn"]!) * 1000)),
        refreshExpiresIn: this["refreshExpiresIn"] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                (int.parse(this["refreshExpiresIn"]!) * 1000))
            : null,
        refreshToken: this["refreshToken"],
        tokenType: this["tokenType"],
        idToken: this["idToken"],
        notBeforePolicy: this["notBeforePolicy"] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                (int.parse(this["notBeforePolicy"]!) * 1000))
            : null,
        sessionState: this["sessionState"],
        scope: this["scope"]);
  }
}

extension EpochDate on String? {
  DateTime? toDateTime() {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    final micros = int.parse(this!) * 1000;
    return DateTime.fromMillisecondsSinceEpoch(micros);
  }
}

extension EpochString on DateTime {
  String toEpochString() {
    final micros = toUtc().millisecondsSinceEpoch;
    return (micros ~/ 1000).toString();
  }
}
