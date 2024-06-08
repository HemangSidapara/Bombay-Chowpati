import 'dart:convert';

/// productId : "instance.productId"
/// productDataId : "instance.productDataId"
/// size : "instance.size"
/// mrp : "instance.mrp"
/// price : "instance.price"
/// quantity : "instance.quantity"

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    String? productId,
    String? productDataId,
    String? size,
    String? mrp,
    String? price,
    String? quantity,
    String? amount,
    String? image,
    String? title,
  }) {
    _productId = productId;
    _productDataId = productDataId;
    _size = size;
    _mrp = mrp;
    _price = price;
    _quantity = quantity;
    _amount = amount;
    _image = image;
    _title = title;
  }

  CartModel.fromJson(dynamic json) {
    _productId = json['productId'];
    _productDataId = json['productDataId'];
    _size = json['size'];
    _mrp = json['mrp'];
    _price = json['price'];
    _quantity = json['quantity'];
    _amount = json['amount'];
    _image = json['image'];
    _title = json['title'];
  }

  String? _productId;
  String? _productDataId;
  String? _size;
  String? _mrp;
  String? _price;
  String? _quantity;
  String? _amount;
  String? _image;
  String? _title;

  CartModel copyWith({
    String? productId,
    String? productDataId,
    String? size,
    String? mrp,
    String? price,
    String? quantity,
    String? amount,
    String? image,
    String? title,
  }) =>
      CartModel(
        productId: productId ?? _productId,
        productDataId: productDataId ?? _productDataId,
        size: size ?? _size,
        mrp: mrp ?? _mrp,
        price: price ?? _price,
        quantity: quantity ?? _quantity,
        amount: amount ?? _amount,
        image: image ?? _image,
        title: title ?? _title,
      );

  set setProductId(String? productId) => _productId = productId;

  String? get productId => _productId;

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

  set setImage(String? image) => _image = image;

  String? get image => _image;

  set setTitle(String? title) => _title = title;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['productDataId'] = _productDataId;
    map['size'] = _size;
    map['mrp'] = _mrp;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['image'] = _image;
    map['title'] = _title;
    return map;
  }
}
