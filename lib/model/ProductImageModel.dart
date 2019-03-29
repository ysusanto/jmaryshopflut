import 'dart:convert';

ProductImage fromJson(String str) {
  final jsonData = json.decode(str);
  return ProductImage.fromJson(jsonData);
}

String toJson(ProductImage data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<ProductImage> allFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ProductImage>.from(jsonData.map((x) => ProductImage.fromJson(x)));
}

String allToJson(List<ProductImage> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class ProductImage {
  String id;
  String nama;
  String thumbPath;
  String path;
  String itemId;

  ProductImage({this.id, this.nama, this.thumbPath, this.path, this.itemId});

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["pict_id"],
        nama: json["nama"],
        thumbPath: json["thumb_path"],
        path: json["path"],
        itemId: json["item_id"],
      );

  Map<String, dynamic> toJson() => {
        "pict_id": id,
        "nama": nama,
        "thumb_path": thumbPath,
        "path": path,
        "item_id": itemId,
      };
}