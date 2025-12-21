// import 'package:ecommerce_app_user/constants/constants.dart';
// import 'package:ecommerce_app_user/constants/routes.dart';
// import 'package:ecommerce_app_user/models/product_model/product_model.dart';
// import 'package:ecommerce_app_user/pages/cart_item_checkout/cart_item_checkout.dart';
// import 'package:ecommerce_app_user/pages/cart_screen/cart_screen.dart';
// import 'package:ecommerce_app_user/provider/app_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProductDetailScreen extends StatefulWidget {
//   const ProductDetailScreen({
//     super.key,
//     required this.singleProduct,
//   });

//   final ProductModel singleProduct;
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int sluong = 1;
//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(widget.singleProduct.image!),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     widget.singleProduct.name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         widget.singleProduct.isFavorite =
//                             !widget.singleProduct.isFavorite;
//                       });
//                       if (widget.singleProduct.isFavorite) {
//                         appProvider.addFavouriteProduct(widget.singleProduct);
//                       } else {
//                         appProvider
//                             .removeFavouriteProduct(widget.singleProduct);
//                       }
//                     },
//                     icon: Icon(
//                       appProvider.getFavouriteProductList
//                               .contains(widget.singleProduct)
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                       color: Colors.red,
//                     ),
//                   )
//                 ],
//               ),
//               Text(widget.singleProduct.description),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   CupertinoButton(
//                     onPressed: () {
//                       if (sluong > 1) {
//                         setState(() {
//                           sluong--;
//                         });
//                       }
//                     },
//                     padding: EdgeInsets.zero,
//                     child: const CircleAvatar(
//                       backgroundColor: Colors.black26,
//                       child: Icon(Icons.remove),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Text(
//                     sluong.toString(),
//                     style: const TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   CupertinoButton(
//                     onPressed: () {
//                       setState(() {
//                         sluong++;
//                       });
//                     },
//                     padding: EdgeInsets.zero,
//                     child: const CircleAvatar(
//                       backgroundColor: Colors.black26,
//                       child: Icon(Icons.add),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () {
//                       ProductModel productModel =
//                           widget.singleProduct.copyWith(sluong: sluong);
//                       appProvider.addCartProduct(productModel);

//                       showMessage("Đã thêm vào giỏ hàng");
//                     },
//                     child: const Text(
//                       "Thêm giỏ hàng",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 42,
//                     width: 150,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         appProvider.clearBuyProduct();
//                         appProvider.addBuyProductCartList();
//                         // appProvider.clearCart();
//                         Routes.instance.push(
//                           widget: const CartItemCheckout(),
//                           context: context,
//                         );

//                         print(appProvider.getCartProductList);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey,
//                       ),
//                       child: const Text(
//                         "Đặt hàng",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/models/product_model/product_model.dart';
import 'package:ecommerce_app_user/pages/cart_item_checkout/cart_item_checkout.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.singleProduct,
  });

  final ProductModel singleProduct;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int sluong = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final product = widget.singleProduct;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      product.isFavorite = !product.isFavorite;
                    });
                    if (product.isFavorite) {
                      appProvider.addFavouriteProduct(product);
                    } else {
                      appProvider.removeFavouriteProduct(product);
                    }
                  },
                  icon: Icon(
                    appProvider.getFavouriteProductList.contains(product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "\$${product.price.toString()}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (sluong > 1) {
                      setState(() => sluong--);
                    }
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    size: 40,
                  ),
                ),
                Text(
                  sluong.toString(),
                  style: const TextStyle(fontSize: 25),
                ),
                IconButton(
                  onPressed: () => setState(() => sluong++),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ProductModel productWithQty =
                          product.copyWith(sluong: sluong);
                      appProvider.addCartProduct(productWithQty);
                      showMessage("Đã thêm vào giỏ hàng");
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text("Thêm vào giỏ hàng"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      appProvider.clearBuyProduct();
                      appProvider.addBuyProductCartList();
                      Routes.instance.push(
                        widget: const CartItemCheckout(),
                        context: context,
                      );
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text("Đặt hàng"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
