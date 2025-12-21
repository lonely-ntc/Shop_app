import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/pages/cart_item_checkout/cart_item_checkout.dart';
import 'package:ecommerce_app_user/pages/cart_screen/widgets/cart_single_item.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          "Giỏ hàng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tổng tiền",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProductCartList();

                    if (appProvider.getBuyProductList.isEmpty) {
                      showMessage("Giỏ hàng rỗng");
                    } else {
                      appProvider.clearCart();
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const CartItemCheckout(),
                        withNavBar: false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Thanh toán",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text(
                "Giỏ hàng đang trống",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, item) {
                return CartSingleItem(
                  singleProduct: appProvider.getCartProductList[item],
                );
              },
            ),
    );
  }
}
