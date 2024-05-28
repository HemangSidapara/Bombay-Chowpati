import 'dart:convert';

/// code : "200"
/// msg : "Get Terms & Condition Successfully"
/// TermsCondition : "This is Terms & Condition"

TermsAndConditionsModel termsAndConditionsModelFromJson(String str) => TermsAndConditionsModel.fromJson(json.decode(str));
String termsAndConditionsModelToJson(TermsAndConditionsModel data) => json.encode(data.toJson());

class TermsAndConditionsModel {
  TermsAndConditionsModel({
    String? code,
    String? msg,
    String? termsCondition,
  }) {
    _code = code;
    _msg = msg;
    _termsCondition = termsCondition;
  }

  TermsAndConditionsModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _termsCondition = json['TermsCondition'];
  }
  String? _code;
  String? _msg;
  String? _termsCondition;
  TermsAndConditionsModel copyWith({
    String? code,
    String? msg,
    String? termsCondition,
  }) =>
      TermsAndConditionsModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        termsCondition: termsCondition ?? _termsCondition,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get termsCondition => _termsCondition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['TermsCondition'] = _termsCondition;
    return map;
  }
}
