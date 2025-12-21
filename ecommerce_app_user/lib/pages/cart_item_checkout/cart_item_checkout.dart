import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app_user/pages/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:ecommerce_app_user/stripe_helper/stripe_helper.dart';
import 'package:ecommerce_app_user/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({super.key});

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Phương thức thanh toán",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildPaymentOption(
              value: 1,
              groupValue: groupValue,
              onChanged: (val) => setState(() => groupValue = val!),
              icon: Icons.attach_money,
              title: "Thanh toán khi nhận hàng",
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              value: 2,
              groupValue: groupValue,
              onChanged: (val) => setState(() => groupValue = val!),
              icon: Icons.credit_card,
              title: "Thanh toán online",
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (groupValue == 1) {
                    bool value = await FirebaseFirestoreHelper.instance
                        .uploadOrderedProductFirebase(
                      appProvider.getBuyProductList,
                      context,
                      "Thanh toán khi nhận hàng",
                    );

                    appProvider.clearBuyProduct();
                    if (value) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Routes.instance.push(
                            widget: const CustomBottomBar(), context: context);
                      });
                    }
                  } else {
                    int value = double.parse(
                            appProvider.totalPriceBuyProductList().toString())
                        .round()
                        .toInt();
                    String totalPrice = (value * 100).toString();
                    await StripeHelper.instance
                        .makePayment(totalPrice.toString(), context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Tiếp tục",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required int value,
    required int groupValue,
    required ValueChanged<int?> onChanged,
    required IconData icon,
    required String title,
  }) {
    bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey.shade400,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.redAccent : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.black : Colors.grey[800],
                ),
              ),
            ),
            Radio<int>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
