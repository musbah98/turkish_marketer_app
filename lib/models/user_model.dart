class UserModel {
  final int? id;
  final int? activateCode;
  final bool? emailVerified;
  final bool? hasCompany;
  //final String? email;
  //final String? username;
  final String? token;
  final String? refreshToken;
  final int? expiresIn;

  UserModel({
    this.id,
    this.activateCode,
    this.emailVerified,
    this.hasCompany,
    //this.username,
    //this.email,
    this.token,
    this.refreshToken,
    this.expiresIn,
  });

  factory UserModel.fromJson(dynamic json) {
    // Cast json to Map<String, dynamic> before accessing its keys
    final map = json as Map<String, dynamic>;

    return UserModel(
      id: map['id'],
      activateCode: map['activate_code'],
      emailVerified: map['email_verified'],
      hasCompany: map['has_company'],
      //username: map['username'],
      //email: map['email'],
      token: map['token'],
      refreshToken: map['refresh_token'],
      expiresIn: map['expires_in'],
    );
  }

  // Method to convert UserModel instance to JSON (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activate_code': activateCode,
      'email_verified': emailVerified,
      'has_company': hasCompany,
      //'username': username,
      //'email': email,
      'token': token,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
    };
  }
}
