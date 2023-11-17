// import 'package:flutter/material.dart';
// import 'package:products_kart/model/product_model.dart';
// import 'package:products_kart/provider/product_provider.dart';
// import 'package:products_kart/sevice/product_api_service.dart';
// import 'package:provider/provider.dart';
//
// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   late ProductModel productModel;
//   late ProductProvider productProvider;
//   List<ProductModel> productList = [];
//
//   @override
//   void initState() {
//     productProvider = Provider.of<ProductProvider>(context, listen: false);
//     getProductInformation();
//     super.initState();
//   }
//
//   Future<void> fetchProduct() async {
//     await productProvider.fetchProduct();
//   }
//
//   Future getProductInformation() async {
//     productList = await ProductApiService.getProductInfo();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product'),
//       ),
//       body: Consumer<ProductProvider>(
//         builder:
//             (BuildContext context, ProductProvider provider, Widget? child) {
//           if (provider.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4),
//             itemCount: provider.productModel?.products?.length ?? 0,
//             itemBuilder: (BuildContext context, int index) {
//               var product = provider.productModel?.products?[index];
//               return Card(
//                 child: ListTile(
//                   title: Column(
//                     children: [
//                       Image.network(product!.images.toString()),
//                       ListTile(
//                         title: Text(product.title.toString()),
//                         subtitle: Text(product.price.toString()),
//                         leading: Text(product.stock.toString()),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:products_kart/model/products_model.dart';
import 'package:products_kart/screen/product_detail_screen.dart';
import 'package:products_kart/sevice/product_api_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductApiService productApi;
  List<Products> productList = [];

  @override
  void initState() {
    super.initState();
    productApi = ProductApiService();
    loadProducts();
  }

  Future<void> loadProducts() async {
    productList = await ProductApiService.getProductInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Products productModel = productList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductDetailScreen(
                      products: productModel,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Card(
                child: Column(
                  children: [
                    Image.network(
                      productModel.images != null && productModel.images!.isNotEmpty
                          ? productModel.images![0]
                          : 'placeholder_url',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    ListTile(
                      title: Text('Name : ${productModel.title}'),
                      subtitle: Text("Price : \$${productModel.price.toString()}"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}