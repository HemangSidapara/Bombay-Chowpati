import 'dart:convert';

/// code : "200"
/// msg : "get Pin Codes Successfully"
/// Data : [{"pinCode":"360001"},{"pinCode":"360002"},{"pinCode":"360003"},{"pinCode":"360004"},{"pinCode":"360005"},{"pinCode":"360006"},{"pinCode":"360007"},{"pinCode":"360020"},{"pinCode":"360022"}]

GetPincodesModel getPincodesModelFromJson(String str) => GetPincodesModel.fromJson(json.decode(str));
String getPincodesModelToJson(GetPincodesModel data) => json.encode(data.toJson());

class GetPincodesModel {
  GetPincodesModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetPincodesModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _code;
  String? _msg;
  List<Data>? _data;
  GetPincodesModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetPincodesModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );
  String? get code => _code;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// pinCode : "360001"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? pinCode,
  }) {
    _pinCode = pinCode;
  }

  Data.fromJson(dynamic json) {
    _pinCode = json['pinCode'];
  }
  String? _pinCode;
  Data copyWith({
    String? pinCode,
  }) =>
      Data(
        pinCode: pinCode ?? _pinCode,
      );
  String? get pinCode => _pinCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pinCode'] = _pinCode;
    return map;
  }
}
