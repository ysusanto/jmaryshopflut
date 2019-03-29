import 'package:jmaryshop/model/ProductModel.dart';

class HomeModel {
  String status;
  String message;
  int allItemCount;
  String statusHapus;
  List<ProductModel> products;
  

  HomeModel(
      {this.status,
      this.message,
      this.allItemCount,
      this.statusHapus,
      this.products,
      });

  factory HomeModel.fromJson(Map<String, dynamic> jsonBalikan) {
    var list = jsonBalikan['data']['item'] as List;
    List<ProductModel> productList = list.map((i) => ProductModel.fromJson(i)).toList();

    

    return HomeModel(
      status: jsonBalikan['status'],
      message: jsonBalikan['message'],
      allItemCount: jsonBalikan['all_item_count'],
      statusHapus: jsonBalikan['status_hapus'],
      products: productList,
     
    );
  }
}