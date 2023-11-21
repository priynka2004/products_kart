import 'package:flutter/cupertino.dart';
import 'package:products_kart/product/model/products_model.dart';
import 'package:products_kart/product/sevice/product_api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Products> productList = [];
  late ProductApiService productApiService;
  late bool isLoading;
  late Products productModel;

  ProductProvider() {
    productApiService = ProductApiService();
    isLoading = false;
  }

  Future<void> fetchProduct() async {
    try {
      isLoading = true;
      notifyListeners();
      productList = await ProductApiService.getProductInfo();

      print(productList);
    } catch (error) {
      print('Error fetching products: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}