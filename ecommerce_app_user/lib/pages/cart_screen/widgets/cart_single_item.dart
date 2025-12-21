import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/models/product_model/product_model.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSingleItem extends StatefulWidget {
  final ProductModel singleProduct;
  const CartSingleItem({super.key, required this.singleProduct});

  @override
  State<CartSingleItem> createState() => _CartSingleItemState();
}

class _CartSingleItemState extends State<CartSingleItem> {
  int sluong = 1;

  @override
  void initState() {
    sluong = widget.singleProduct.sluong ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isFavorite =
        appProvider.getFavouriteProductList.contains(widget.singleProduct);

    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.singleProduct.image!,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.singleProduct.name.length > 18
                        ? "${widget.singleProduct.name.substring(0, 18)}..."
                        : widget.singleProduct.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${widget.singleProduct.price}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (sluong > 1) {
                            setState(() => sluong--);
                            appProvider.updateSluong(
                                widget.singleProduct, sluong);
                          } else {
                            appProvider.removeCartProduct(widget.singleProduct);
                            showMessage("Đã xóa sản phẩm");
                          }
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.black26,
                          maxRadius: 13,
                          child: Icon(Icons.remove, size: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          sluong.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() => sluong++);
                          appProvider.updateSluong(
                              widget.singleProduct, sluong);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.black26,
                          maxRadius: 13,
                          child: Icon(Icons.add, size: 18),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      isFavorite
                          ? appProvider
                              .removeFavouriteProduct(widget.singleProduct)
                          : appProvider
                              .addFavouriteProduct(widget.singleProduct);
                    },
                    child: Text(
                      isFavorite ? "Xóa khỏi yêu thích" : "Thêm vào yêu thích",
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  appProvider.removeCartProduct(widget.singleProduct);
                  showMessage("Đã xóa sản phẩm");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
