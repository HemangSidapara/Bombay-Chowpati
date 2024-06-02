import 'dart:convert';

/// code : "200"
/// msg : "get Products Successfully"
/// Data : [{"pid":"1","title":"Venila","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg","product_data":[{"id":"7","size":"5 Litre","mrp":"500","price":"500"},{"id":"8","size":"750 ML","mrp":"95","price":"95"}]},{"pid":"2","title":"Mango","image":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024e9fdf9da-9aaa-4ac4-bea4-cc72be44927d.jpeg","thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024e9fdf9da-9aaa-4ac4-bea4-cc72be44927d.jpeg","cover":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520246db70db4-65fa-4bbb-ad7b-b8f92de8e9d2.jpeg","cover_thumb":"https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520246db70db4-65fa-4bbb-ad7b-b8f92de8e9d2.jpeg","product_data":[{"id":"9","size":"5 Litre","mrp":"500","price":"500"},{"id":"10","size":"750 ML","mrp":"105","price":"105"}]}]

GetProductsModel getProductsModelFromJson(String str) => GetProductsModel.fromJson(json.decode(str));

String getProductsModelToJson(GetProductsModel data) => json.encode(data.toJson());

class GetProductsModel {
  GetProductsModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetProductsModel.fromJson(dynamic json) {
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

  GetProductsModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetProductsModel(
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

/// pid : "1"
/// title : "Venila"
/// image : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg"
/// thumb : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/280520243bc4ea2b-2134-41cd-9eee-93adc09227d9.jpeg"
/// cover : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg"
/// cover_thumb : "https://mindwaveinfoway.com/BombayChopati/AdminPanel/products/thumb/28052024f5c0546f-8cda-4cb5-810c-ef905667b4c3.jpeg"
/// product_data : [{"id":"7","size":"5 Litre","mrp":"500","price":"500"},{"id":"8","size":"750 ML","mrp":"95","price":"95"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? pid,
    String? title,
    String? image,
    String? thumb,
    String? cover,
    String? coverThumb,
    List<ProductData>? productData,
  }) {
    _pid = pid;
    _title = title;
    _image = image;
    _thumb = thumb;
    _cover = cover;
    _coverThumb = coverThumb;
    _productData = productData;
  }

  Data.fromJson(dynamic json) {
    _pid = json['pid'];
    _title = json['title'];
    _image = json['image'];
    _thumb = json['thumb'];
    _cover = json['cover'];
    _coverThumb = json['cover_thumb'];
    if (json['product_data'] != null) {
      _productData = [];
      json['product_data'].forEach((v) {
        _productData?.add(ProductData.fromJson(v));
      });
    }
  }

  String? _pid;
  String? _title;
  String? _image;
  String? _thumb;
  String? _cover;
  String? _coverThumb;
  List<ProductData>? _productData;

  Data copyWith({
    String? pid,
    String? title,
    String? image,
    String? thumb,
    String? cover,
    String? coverThumb,
    List<ProductData>? productData,
  }) =>
      Data(
        pid: pid ?? _pid,
        title: title ?? _title,
        image: image ?? _image,
        thumb: thumb ?? _thumb,
        cover: cover ?? _cover,
        coverThumb: coverThumb ?? _coverThumb,
        productData: productData ?? _productData,
      );

  String? get pid => _pid;

  String? get title => _title;

  String? get image => _image;

  String? get thumb => _thumb;

  String? get cover => _cover;

  String? get coverThumb => _coverThumb;

  List<ProductData>? get productData => _productData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pid'] = _pid;
    map['title'] = _title;
    map['image'] = _image;
    map['thumb'] = _thumb;
    map['cover'] = _cover;
    map['cover_thumb'] = _coverThumb;
    if (_productData != null) {
      map['product_data'] = _productData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "7"
/// size : "5 Litre"
/// mrp : "500"
/// price : "500"

ProductData productDataFromJson(String str) => ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  ProductData({
    String? id,
    String? size,
    String? mrp,
    String? price,
  }) {
    _id = id;
    _size = size;
    _mrp = mrp;
    _price = price;
  }

  ProductData.fromJson(dynamic json) {
    _id = json['id'];
    _size = json['size'];
    _mrp = json['mrp'];
    _price = json['price'];
  }

  String? _id;
  String? _size;
  String? _mrp;
  String? _price;

  ProductData copyWith({
    String? id,
    String? size,
    String? mrp,
    String? price,
  }) =>
      ProductData(
        id: id ?? _id,
        size: size ?? _size,
        mrp: mrp ?? _mrp,
        price: price ?? _price,
      );

  String? get id => _id;

  String? get size => _size;

  String? get mrp => _mrp;

  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['size'] = _size;
    map['mrp'] = _mrp;
    map['price'] = _price;
    return map;
  }
}
