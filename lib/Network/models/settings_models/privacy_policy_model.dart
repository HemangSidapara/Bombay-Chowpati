import 'dart:convert';

/// code : "200"
/// msg : "Get Privacy Policy Successfully"
/// PrivacyPolicy : "This is Privacy Policy"

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));
String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    String? code,
    String? msg,
    String? privacyPolicy,
  }) {
    _code = code;
    _msg = msg;
    _privacyPolicy = privacyPolicy;
  }

  PrivacyPolicyModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _privacyPolicy = json['PrivacyPolicy'];
  }
  String? _code;
  String? _msg;
  String? _privacyPolicy;
  PrivacyPolicyModel copyWith({
    String? code,
    String? msg,
    String? privacyPolicy,
  }) =>
      PrivacyPolicyModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        privacyPolicy: privacyPolicy ?? _privacyPolicy,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get privacyPolicy => _privacyPolicy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['PrivacyPolicy'] = _privacyPolicy;
    return map;
  }
}
