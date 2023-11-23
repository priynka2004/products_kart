import 'package:flutter/material.dart';
import 'package:products_kart/product/model/products_model.dart';
import 'package:products_kart/product/screen/liked_product_screen.dart';
import 'package:products_kart/product/sevice/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products? products;

  const ProductDetailScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLiked = true;
 // int isLikedCount = 0;

  void likedCount() async{
    setState(() {
     // isLikedCount = isLiked ? isLikedCount + 1 : isLikedCount-1;
    });
   // await SharedPrefService.setLikedCount(widget.products!.id!.toInt() //isLikedCount
         //);
  }

  @override
  void initState() {
    super.initState();
    likedProducts();
  }

  void likedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await SharedPrefService.getProduct();
    isLiked = value;
    bool liked = prefs.getBool(widget.products!.id.toString()) ?? true;
   // isLikedCount = await SharedPrefService.getLikedCount(widget.products!.id!.toInt());
    setState(() {
      isLiked = liked;
    });
  }

  void unLikedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.products!.id.toString(), !isLiked);
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return  LikedProductsScreen();
            }));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.products!.images!.first.toString()),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(widget.products?.title ?? ''),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          //Text("$isLikedCount"),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                              likedCount();
                              unLikedProducts();
                              SharedPrefService.setProduct(isLiked);
                              SharedPrefService.updateLikedProducts(
                                  widget.products!, isLiked);
                            },
                            child: Icon(
                              isLiked ? Icons.thumb_up_alt_outlined : Icons.thumb_up_alt_rounded,
                              color: isLiked ? Colors.black : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text("\$ ${widget.products!.price}"),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
              Text("Discount ${widget.products!.discountPercentage}%"),
              const SizedBox(height: 8),
              Text("${widget.products!.description}"),
              SizedBox(
                height: 30,
                width: 87,
                child: Text("Rating ${widget.products!.rating}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}