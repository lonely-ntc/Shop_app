import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/models/product_model/product_model.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleFavouriteProduct extends StatefulWidget {
  SingleFavouriteProduct({super.key, required this.singleProduct});
  ProductModel singleProduct;

  @override
  State<SingleFavouriteProduct> createState() => _SingleFavouriteProductState();
}

class _SingleFavouriteProductState extends State<SingleFavouriteProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red,
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.red.withOpacity(0.5),
              child: Image.network(widget.singleProduct.image!),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name.length > 14
                                  ? "${widget.singleProduct.name.substring(0, 14)}..."
                                  : widget.singleProduct.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                AppProvider appProvider =
                                    Provider.of<AppProvider>(context,
                                        listen: false);
                                appProvider.removeFavouriteProduct(
                                    widget.singleProduct);
                                showMessage("Đã xóa khỏi yêu thích");
                              },
                              padding: EdgeInsets.zero,
                              child: const Text(
                                "Xóa khỏi yêu thích",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${widget.singleProduct.price.toString()}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
