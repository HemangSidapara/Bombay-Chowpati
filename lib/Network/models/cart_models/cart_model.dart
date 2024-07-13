import 'dart:convert';

/// productId : "instance.productId"
/// sizes : ["instance.size"]
/// mrp : "instance.mrp"
/// price : "instance.price"
/// quantity : "instance.quantity"

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    String? productId,
    String? title,
    String? image,
    List<SizeModel>? sizes,
  }) {
    _productId = productId;
    _title = title;
    _image = image;
    _sizes = sizes;
  }

  CartModel.fromJson(dynamic json) {
    _productId = json['productId'];
    _title = json['title'];
    _image = json['image'];
    if (json['sizes'] != null) {
      _sizes = [];
      json['sizes'].forEach((v) {
        _sizes?.add(SizeModel.fromJson(v));
      });
    }
  }

  String? _productId;
  String? _title;
  String? _image;
  List<SizeModel>? _sizes;

  CartModel copyWith({
    String? productId,
    String? title,
    String? image,
    List<SizeModel>? sizes,
  }) =>
      CartModel(
        productId: productId ?? _productId,
        title: title ?? _title,
        image: image ?? _image,
        sizes: sizes ?? _sizes,
      );

  set setProductId(String? productId) => _productId = productId;

  String? get productId => _productId;

  set setTitle(String? title) => _title = title;

  String? get title => _title;

  set setImage(String? image) => _image = image;

  String? get image => _image;

  set setSizes(List<SizeModel>? sizes) => _sizes?.addAll(sizes ?? []);

  set removeSizes(String? productDataId) => _sizes?.removeWhere((element) => element.productDataId == productDataId);

  List<SizeModel>? get sizes => _sizes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['title'] = _title;
    map['image'] = _image;
    if (_sizes != null) {
      map['sizes'] = _sizes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// size : "instance.size"
/// mrp : "instance.mrp"
/// price : "instance.price"
/// quantity : "instance.quantity"

SizeModel sizeModelFromJson(String str) => SizeModel.fromJson(json.decode(str));

String sizeModelToJson(SizeModel data) => json.encode(data.toJson());

class SizeModel {
  SizeModel({
    String? productDataId,
    String? size,
    String? mrp,
    String? price,
    String? quantity,
    String? amount,
  }) {
    _productDataId = productDataId;
    _size = size;
    _mrp = mrp;
    _price = price;
    _quantity = quantity;
    _amount = amount;
  }

  SizeModel.fromJson(dynamic json) {
    _productDataId = json['productDataId'];
    _size = json['size'];
    _mrp = json['mrp'];
    _price = json['price'];
    _quantity = json['quantity'];
    _amount = json['amount'];
  }

  String? _productDataId;
  String? _size;
  String? _mrp;
  String? _price;
  String? _quantity;
  String? _amount;

  SizeModel copyWith({
    String? productDataId,
    String? size,
    String? mrp,
    String? price,
    String? quantity,
    String? amount,
  }) =>
      SizeModel(
        productDataId: productDataId ?? _productDataId,
        size: size ?? _size,
        mrp: mrp ?? _mrp,
        price: price ?? _price,
        quantity: quantity ?? _quantity,
        amount: amount ?? _amount,
      );

  set setProductDataId(String? productDataId) => _productDataId = productDataId;

  String? get productDataId => _productDataId;

  set setSize(String? size) => _size = size;

  String? get size => _size;

  set setMrp(String? mrp) => _mrp = mrp;

  String? get mrp => _mrp;

  set setPrice(String? price) => _price = price;

  String? get price => _price;

  set setQuantity(String? quantity) => _quantity = quantity;

  String? get quantity => _quantity;

  set setAmount(String? amount) => _amount = amount;

  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productDataId'] = _productDataId;
    map['size'] = _size;
    map['mrp'] = _mrp;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    return map;
  }
}
