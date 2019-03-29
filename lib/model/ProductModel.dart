import 'dart:convert';

import 'package:jmaryshop/model/ProductImageModel.dart';

ProductModel productFromJson(String str) {
  final jsonData = json.decode(str);
  return ProductModel.fromJson(jsonData);
}

class ProductModel {
  String itemId;
  String itemCode;
  String shopId;
  String shopName;
  String name;
  int price;
  String desc;
  String subCategoryId;
  String isHideHarga;
  int jumlah;
  int minJumlah;
  String minSatuan;
  String isPremium;
  String isSold;
  String isNew;
  String weight;
  String isLike;
  String verifyStat;
  int stockBoleci;
  String createDate;
  int modifiedDate;
  String imageLink;
  // List<ProductPrice> prices;
  List<ProductImage> images;

  ProductModel(
      {this.itemId,
      this.itemCode,
      this.shopId,
      this.shopName,
      this.name,
      this.price,
      this.desc,
      this.subCategoryId,
      this.isHideHarga,
      this.jumlah,
      this.minJumlah,
      this.minSatuan,
      this.isPremium,
      this.isSold,
      this.isNew,
      this.weight,
      this.isLike,
      this.verifyStat,
      this.stockBoleci,
      this.createDate,
      this.modifiedDate,
      this.imageLink,
      // this.prices,
      this.images
      });

  factory ProductModel.fromJson(Map<String, dynamic> json) {

    var listImage = json['listpict_multiple'] as List;
    List<ProductImage> imageList = listImage.map((i) => ProductImage.fromJson(i)).toList();

    return ProductModel(
        itemId: json["item_id"],
        itemCode: json["item_code"],
        shopId: json["shop_id"],
        shopName: json["nama_toko"],
        name: json["nama"],
        price: json["harga"],
        desc: json["desc"],
        subCategoryId: json["subcategory_id"],
        isHideHarga: json["is_hideharga"],
        jumlah: json["jumlah"],
        minJumlah: json["min_jumlah"],
        minSatuan: json["min_satuan"],
        isPremium: json["is_premium"],
        isSold: json["is_sold"],
        isNew: json["is_new"],
        weight: json["weight"],
        isLike: json["is_like"],
        verifyStat: json["verify_stat"],
        stockBoleci: json["stock_boleci"],
        createDate: json["tanggal"],
        modifiedDate: json["modified_date"],
        imageLink: json['listpict']['thumb_path'],
        images: imageList
      );
  }

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_code": itemCode,
        "shop_id": shopId,
        "nama_toko": shopName,
        "nama": name,
        "harga": price,
        "desc": desc,
        "subcategory_id": subCategoryId,
        "is_hideharga": isHideHarga,
        "jumlah": jumlah,
        "min_jumlah": minJumlah,
        "min_satuan": minSatuan,
        "is_premium": isPremium,
        "is_sold": isSold,
        "is_new": isNew,
        "weight": weight,
        "is_like": isLike,
        "verify_stat": verifyStat,
        "stock_boleci": stockBoleci,
        "tanggal": createDate,
        "modified_date": modifiedDate,
      };
}

String productToJson(ProductModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<ProductModel> allProductFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ProductModel>.from(jsonData.map((x) => ProductModel.fromJson(x)));
}

String allProductToJson(List<ProductModel> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}