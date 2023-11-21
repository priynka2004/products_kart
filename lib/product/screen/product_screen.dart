import 'package:flutter/material.dart';
import 'package:products_kart/product/model/products_model.dart';
import 'package:products_kart/product/provider/product_provider.dart';
import 'package:products_kart/product/screen/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductProvider productProvider;

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context,listen: false);
    productProvider.fetchProduct();
    super.initState();
  }

  Future<void> loadProducts() async {
   await productProvider.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider provider, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product'),
            ),
            body: provider.isLoading
            ? const Center(
              child: CircularProgressIndicator(),
            ) : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 4, crossAxisCount: 2
              ),
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  Products productModel = provider.productList[index];
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
                      child: Column(
                        children: [
                          Image.network(
                            productModel.images != null &&
                                productModel.images!.isNotEmpty
                                ? productModel.images![0]
                                : 'placeholder_url',
                            fit: BoxFit.fill,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.12,
                          ),
                          ListTile(
                            title: Text('${productModel.title}',style: TextStyle(fontSize: 12),),
                            subtitle: Text(
                                "\$${productModel.price.toString()}"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
        }
    );
  }
}

