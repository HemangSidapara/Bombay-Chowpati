import 'dart:convert';

/// code : "200"
/// msg : "Login Successfully"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsInBob25lIjoiODEyODUwNTc2In0.17f7c7951863b1ed760cff8598252853d218167a998d08c37fe7e437b90b417d"
/// userId : "1"
/// name : "Gaurav Patel"
/// email : "kachhadiya.gaurav@gmail.com"
/// phone : "812850576"

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    String? code,
    String? msg,
    String? token,
    String? userId,
    String? name,
    String? email,
    String? phone,
  }) {
    _code = code;
    _msg = msg;
    _token = token;
    _userId = userId;
    _name = name;
    _email = email;
    _phone = phone;
  }

  LoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _token = json['token'];
    _userId = json['userId'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
  }
  String? _code;
  String? _msg;
  String? _token;
  String? _userId;
  String? _name;
  String? _email;
  String? _phone;
  LoginModel copyWith({
    String? code,
    String? msg,
    String? token,
    String? userId,
    String? name,
    String? email,
    String? phone,
  }) =>
      LoginModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        token: token ?? _token,
        userId: userId ?? _userId,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get token => _token;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['token'] = _token;
    map['userId'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    return map;
  }
}
