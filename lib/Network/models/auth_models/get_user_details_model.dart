import 'dart:convert';

/// code : "200"
/// msg : "Get User Detail Successfully"
/// userId : "1"
/// name : "Varun Bhai"
/// email : "kachhadiya.gaurav@gmail.com"
/// phone : "812850576"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsInBob25lIjoiODEyODUwNTc2In0.17f7c7951863b1ed760cff8598252853d218167a998d08c37fe7e437b90b417d"

GetUserDetailsModel getUserDetailsModelFromJson(String str) => GetUserDetailsModel.fromJson(json.decode(str));
String getUserDetailsModelToJson(GetUserDetailsModel data) => json.encode(data.toJson());

class GetUserDetailsModel {
  GetUserDetailsModel({
    String? code,
    String? msg,
    String? userId,
    String? name,
    String? email,
    String? phone,
    String? token,
  }) {
    _code = code;
    _msg = msg;
    _userId = userId;
    _name = name;
    _email = email;
    _phone = phone;
    _token = token;
  }

  GetUserDetailsModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _userId = json['userId'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _token = json['token'];
  }
  String? _code;
  String? _msg;
  String? _userId;
  String? _name;
  String? _email;
  String? _phone;
  String? _token;
  GetUserDetailsModel copyWith({
    String? code,
    String? msg,
    String? userId,
    String? name,
    String? email,
    String? phone,
    String? token,
  }) =>
      GetUserDetailsModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        userId: userId ?? _userId,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        token: token ?? _token,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['userId'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['token'] = _token;
    return map;
  }
}
