import 'dart:convert';

/// code : "200"
/// msg : "get Orders Successfully"
/// Data : [{"orderId":"3","addressId":"6","address":"512, Shivalay Complex, Near Ashiward Hospital, Mavdi, Rajkot","totalAmount":"500","status":"Pending","createdDate":"2024-06-08 10:48:22","orderMeta":[{"orderMetaId":"4","pid":"1","title":"Venila","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","pMetaId":"7","size":"5 Litre","quantity":"1","amount":"500"}]},{"orderId":"2","addressId":"6","address":"512, Shivalay Complex, Near Ashiward Hospital, Mavdi, Rajkot","totalAmount":"1200","status":"Pending","createdDate":"2024-06-08 10:46:28","orderMeta":[{"orderMetaId":"2","pid":"1","title":"Venila","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","pMetaId":"7","size":"5 Litre","quantity":"1","amount":"400"},{"orderMetaId":"3","pid":"2","title":"Mango","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024e9fdf9da-9aaa-4ac4-bea4-cc72be44927d.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024e9fdf9da-9aaa-4ac4-bea4-cc72be44927d.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520246db70db4-65fa-4bbb-ad7b-b8f92de8e9d2.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520246db70db4-65fa-4bbb-ad7b-b8f92de8e9d2.jpeg","pMetaId":"9","size":"5 Litre","quantity":"2","amount":"800"}]},{"orderId":"1","addressId":"1","address":"","totalAmount":"550","status":"Cancel","createdDate":"2024-06-04 02:14:23","orderMeta":[{"orderMetaId":"1","pid":"1","title":"Venila","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","pMetaId":"7","size":"5 Litre","quantity":"2","amount":"250"}]}]

GetOrdersModel getOrdersModelFromJson(String str) => GetOrdersModel.fromJson(json.decode(str));
String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());

class GetOrdersModel {
  GetOrdersModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetOrdersModel.fromJson(dynamic json) {
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
  GetOrdersModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetOrdersModel(
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

/// orderId : "3"
/// addressId : "6"
/// address : "512, Shivalay Complex, Near Ashiward Hospital, Mavdi, Rajkot"
/// totalAmount : "500"
/// status : "Pending"
/// createdDate : "2024-06-08 10:48:22"
/// orderMeta : [{"orderMetaId":"4","pid":"1","title":"Venila","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","pMetaId":"7","size":"5 Litre","quantity":"1","amount":"500"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? orderId,
    String? addressId,
    String? address,
    String? totalAmount,
    String? status,
    String? createdDate,
    List<OrderMeta>? orderMeta,
  }) {
    _orderId = orderId;
    _addressId = addressId;
    _address = address;
    _totalAmount = totalAmount;
    _status = status;
    _createdDate = createdDate;
    _orderMeta = orderMeta;
  }

  Data.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _addressId = json['addressId'];
    _address = json['address'];
    _totalAmount = json['totalAmount'];
    _status = json['status'];
    _createdDate = json['createdDate'];
    if (json['orderMeta'] != null) {
      _orderMeta = [];
      json['orderMeta'].forEach((v) {
        _orderMeta?.add(OrderMeta.fromJson(v));
      });
    }
  }
  String? _orderId;
  String? _addressId;
  String? _address;
  String? _totalAmount;
  String? _status;
  String? _createdDate;
  List<OrderMeta>? _orderMeta;
  Data copyWith({
    String? orderId,
    String? addressId,
    String? address,
    String? totalAmount,
    String? status,
    String? createdDate,
    List<OrderMeta>? orderMeta,
  }) =>
      Data(
        orderId: orderId ?? _orderId,
        addressId: addressId ?? _addressId,
        address: address ?? _address,
        totalAmount: totalAmount ?? _totalAmount,
        status: status ?? _status,
        createdDate: createdDate ?? _createdDate,
        orderMeta: orderMeta ?? _orderMeta,
      );
  String? get orderId => _orderId;
  String? get addressId => _addressId;
  String? get address => _address;
  String? get totalAmount => _totalAmount;
  String? get status => _status;
  String? get createdDate => _createdDate;
  List<OrderMeta>? get orderMeta => _orderMeta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['addressId'] = _addressId;
    map['address'] = _address;
    map['totalAmount'] = _totalAmount;
    map['status'] = _status;
    map['createdDate'] = _createdDate;
    if (_orderMeta != null) {
      map['orderMeta'] = _orderMeta?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// orderMetaId : "4"
/// pid : "1"
/// title : "Venila"
/// image : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg"
/// thumb : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg"
/// cover : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg"
/// cover_thumb : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg"
/// pMetaId : "7"
/// size : "5 Litre"
/// quantity : "1"
/// amount : "500"

OrderMeta orderMetaFromJson(String str) => OrderMeta.fromJson(json.decode(str));
String orderMetaToJson(OrderMeta data) => json.encode(data.toJson());

class OrderMeta {
  OrderMeta({
    String? orderMetaId,
    String? pid,
    String? title,
    String? image,
    String? thumb,
    String? cover,
    String? coverThumb,
    String? pMetaId,
    String? size,
    String? quantity,
    String? amount,
  }) {
    _orderMetaId = orderMetaId;
    _pid = pid;
    _title = title;
    _image = image;
    _thumb = thumb;
    _cover = cover;
    _coverThumb = coverThumb;
    _pMetaId = pMetaId;
    _size = size;
    _quantity = quantity;
    _amount = amount;
  }

  OrderMeta.fromJson(dynamic json) {
    _orderMetaId = json['orderMetaId'];
    _pid = json['pid'];
    _title = json['title'];
    _image = json['image'];
    _thumb = json['thumb'];
    _cover = json['cover'];
    _coverThumb = json['cover_thumb'];
    _pMetaId = json['pMetaId'];
    _size = json['size'];
    _quantity = json['quantity'];
    _amount = json['amount'];
  }
  String? _orderMetaId;
  String? _pid;
  String? _title;
  String? _image;
  String? _thumb;
  String? _cover;
  String? _coverThumb;
  String? _pMetaId;
  String? _size;
  String? _quantity;
  String? _amount;
  OrderMeta copyWith({
    String? orderMetaId,
    String? pid,
    String? title,
    String? image,
    String? thumb,
    String? cover,
    String? coverThumb,
    String? pMetaId,
    String? size,
    String? quantity,
    String? amount,
  }) =>
      OrderMeta(
        orderMetaId: orderMetaId ?? _orderMetaId,
        pid: pid ?? _pid,
        title: title ?? _title,
        image: image ?? _image,
        thumb: thumb ?? _thumb,
        cover: cover ?? _cover,
        coverThumb: coverThumb ?? _coverThumb,
        pMetaId: pMetaId ?? _pMetaId,
        size: size ?? _size,
        quantity: quantity ?? _quantity,
        amount: amount ?? _amount,
      );
  String? get orderMetaId => _orderMetaId;
  String? get pid => _pid;
  String? get title => _title;
  String? get image => _image;
  String? get thumb => _thumb;
  String? get cover => _cover;
  String? get coverThumb => _coverThumb;
  String? get pMetaId => _pMetaId;
  String? get size => _size;
  String? get quantity => _quantity;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderMetaId'] = _orderMetaId;
    map['pid'] = _pid;
    map['title'] = _title;
    map['image'] = _image;
    map['thumb'] = _thumb;
    map['cover'] = _cover;
    map['cover_thumb'] = _coverThumb;
    map['pMetaId'] = _pMetaId;
    map['size'] = _size;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    return map;
  }
}
