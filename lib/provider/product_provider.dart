import 'package:flutter/cupertino.dart';
import 'package:products_kart/model/products_model.dart';
import 'package:products_kart/sevice/product_api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Products> productList = [];
  late ProductApiService productApiService;
  late bool isLoading;
  late Products productModel;

  ProductProvider() {
    productApiService = productApiService;
    isLoading = false;
  }
}