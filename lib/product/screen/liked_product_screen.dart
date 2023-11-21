import 'package:flutter/material.dart';
import 'package:products_kart/product/model/products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedProductsScreen extends StatelessWidget {
   LikedProductsScreen({super.key});

  List<Products> list=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Products'),
      ),
      body:
      FutureBuilder<List<String>>(
        future: getLikedProducts(),
        builder: (context, list) {
            return
              ListView.builder(
              itemCount: list.data!.length,
              itemBuilder: (context, index) {
                List<String> productList = list.data![index].split(",");
                String title = productList[0];
                String price = productList[1];
                String discount = productList[2];
                String description = productList[3];
                String image = productList[4];
                return ListTile(
                  leading: Image.network(image),
                  title: Text(title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price: \$ $price"),
                      Text("Discount: $discount%"),
                      Text(description),
                    ],
                  ),
                );
              },
            );
          }
      ),
    );
  }

  Future<List<String>> getLikedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('likedProducts') ?? [];
  }

  void unlikeProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedProducts = prefs.getStringList('likedProducts') ?? [];

    if (index >= 0 && index < likedProducts.length) {
      likedProducts.removeAt(index);
      prefs.setStringList('likedProducts', likedProducts);
    }
  }
}
