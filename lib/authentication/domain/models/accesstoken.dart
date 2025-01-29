class Accesstoken {
  Accesstoken(
      {required this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.refreshExpiresIn,
      this.notBeforePolicy,
      this.scope,
      this.sessionState,
      this.idToken});

  String? accessToken;
  String? tokenType;
  DateTime? expiresIn;
  String? refreshToken;
  DateTime? refreshExpiresIn;
  DateTime? notBeforePolicy;
  String? scope;
  String? sessionState;
  String? idToken;

  bool get isValid {
    if (accessToken != null) {
      if (expiresIn != null) {
        return expiresIn!.isAfter(DateTime.now().add(Duration(minutes: 1)));
      }
      return false;
    }
    return false;
  }

  bool get isRefreshValid {
    if (refreshToken != null) {
      if (refreshExpiresIn != null) {
        return refreshExpiresIn!
            .isAfter(DateTime.now().add(Duration(minutes: 1)));
      }
      return false;
    }
    return false;
  }
}
