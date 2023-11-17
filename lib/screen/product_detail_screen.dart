import 'package:flutter/material.dart';
import 'package:products_kart/model/products_model.dart';


class ProductDetailScreen extends StatefulWidget {
  Products products;

  ProductDetailScreen({super.key, required this.products});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.network(
                widget.products.images.toString(),
                width: 250,
                height: 250,
              ),
            ),
            ListTile(
              title: Text(
                  widget.products.title.toString()
              ),
              subtitle: Text('\u0024${widget.products.price.toString()}'),
              trailing: Column(
                children: [
                  const Text(
                    'Ratting',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      widget.products.rating.toString()
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(widget.products.description.toString()),
            )
          ],
        ),
      ),
    );
  }
}
