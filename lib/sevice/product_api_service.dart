import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:products_kart/model/product_model.dart';
import 'package:products_kart/util/api_endpoint.dart';

class MatchApiService {
  static Future<ProductModel> getProductInformation() async {
    http.Response response = await http.get(
      Uri.parse(ApiEndPoint.baseUrl()),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }

      final result = jsonDecode(response.body);
      return ProductModel.fromJson(result);

    } else {
      throw "Something went wrong";
    }
  }
}






