class OTPModel {
  int? timeRemaining;
  bool? isLimitExceeded;
  String? msg;
  int? statusCode;

  OTPModel({
    this.timeRemaining,
    this.isLimitExceeded,
    this.msg,
    this.statusCode,
  });

  OTPModel.fromJson(Map<String, dynamic> json, String? msg, int statusCode) {
    timeRemaining = json['timeRemaining'];
    isLimitExceeded = json['isLimitExceeded'];
    msg = msg;
    statusCode = statusCode;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['timeRemaining'] = timeRemaining;
    data['isLimitExceeded'] = isLimitExceeded;
    data['msg'] = msg;
    data['statusCode'] = statusCode;
    return data;
  }
}

class SettingsOTP {
  int? userId;
  int? resend;
  int? maxResend;
  int? lastSend;

  SettingsOTP({this.userId, this.resend, this.maxResend, this.lastSend});

  SettingsOTP.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    resend = json['resend'];
    maxResend = json['maxResend'];
    lastSend = json['lastSend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['resend'] = resend;
    data['maxResend'] = maxResend;
    data['lastSend'] = lastSend;
    return data;
  }
}
