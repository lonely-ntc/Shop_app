import 'package:ecommerce_app_user/pages/favourite_screen/widgets/single_favourite_product.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sản phẩm yêu thích",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: appProvider.getFavouriteProductList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (ctx, item) {
          return SingleFavouriteProduct(
            singleProduct: appProvider.getFavouriteProductList[item],
          );
        },
      ),
    );
  }
}
