import 'dart:convert';

/// code : "200"
/// msg : "get Address Successfully"
/// Data : [{"addressId":"3","address":"512, Shivalay Complex, Near Ashirwad Hospital Rajkot","pinCode":"360311"}]

GetAddressModel getAddressModelFromJson(String str) => GetAddressModel.fromJson(json.decode(str));

String getAddressModelToJson(GetAddressModel data) => json.encode(data.toJson());

class GetAddressModel {
  GetAddressModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetAddressModel.fromJson(dynamic json) {
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

  GetAddressModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetAddressModel(
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

/// addressId : "3"
/// address : "512, Shivalay Complex, Near Ashirwad Hospital Rajkot"
/// pinCode : "360311"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? addressId,
    String? address,
    String? pinCode,
    String? phone,
    bool? isDefault,
  }) {
    _addressId = addressId;
    _address = address;
    _pinCode = pinCode;
    _phone = phone;
    _isDefault = isDefault;
  }

  Data.fromJson(dynamic json) {
    _addressId = json['addressId'];
    _address = json['address'];
    _pinCode = json['pinCode'];
    _phone = json['phone'];
    _isDefault = json['isDefault'];
  }

  String? _addressId;
  String? _address;
  String? _pinCode;
  String? _phone;
  bool? _isDefault;

  Data copyWith({
    String? addressId,
    String? address,
    String? pinCode,
    String? phone,
    bool? isDefault,
  }) =>
      Data(
        addressId: addressId ?? _addressId,
        address: address ?? _address,
        pinCode: pinCode ?? _pinCode,
        phone: phone ?? _phone,
        isDefault: isDefault ?? _isDefault,
      );

  String? get addressId => _addressId;

  String? get address => _address;

  String? get pinCode => _pinCode;

  String? get phone => _phone;

  bool? get isDefault => _isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addressId'] = _addressId;
    map['address'] = _address;
    map['pinCode'] = _pinCode;
    map['phone'] = _phone;
    map['isDefault'] = _isDefault;
    return map;
  }
}
