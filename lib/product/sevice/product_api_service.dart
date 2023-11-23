import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products_kart/product/model/products_model.dart';
import 'package:products_kart/product/sevice/product_response.dart';
import 'package:products_kart/util/api_endpoint.dart';

class ProductApiService{
  static Future<List<Products>> getProductInfo() async {
    String url = ApiEndPoint.getProducts;
    http.Response response = await http.get(
      Uri.parse(url),

    );
    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);

      ProductResponseList productResponseList= ProductResponseList.fromJson(data);
      return productResponseList.products;
    } else {
      throw 'Something went wrong';
    }
  }
}