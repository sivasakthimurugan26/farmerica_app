class TokenResponses {
  String? token;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;


  TokenResponses(
      {this.token, this.userEmail, this.userNicename, this.userDisplayName});

  TokenResponses.fromJson(Map<String, dynamic> json) {
    token = json['data']['token'];
    userEmail = json['user_email'];
    userNicename = json[' user_nicename'];
    userDisplayName = json['user_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_email'] = this.userEmail;
    data[' user_nicename'] = this.userNicename;
    data['user_display_name'] = this.userDisplayName;
    return data;
  }
}
