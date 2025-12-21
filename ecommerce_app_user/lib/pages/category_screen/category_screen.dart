import 'package:ecommerce_app_user/pages/product_detail_screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app_user/models/category_model/category_model.dart';
import 'package:ecommerce_app_user/models/product_model/product_model.dart';
// import 'package:ecommerce_app_user/screens/product_detail/product_details.dart';

class CategoryScreen extends StatefulWidget {
  CategoryModel categoryModel;
  CategoryScreen({super.key, required this.categoryModel});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  Map<String, String> categoryTranslations = {
    "Phone": "Điện thoại",
    "Mouse": "Chuột",
    "Keyboard": "Bàn phím",
    "Headphone": "Tai nghe",
  };

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: kToolbarHeight * 0.1),
          Container(
            padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 13),
              child: Row(
                children: [
                  const BackButton(
                    color: Colors.white,
                  ),
                  Text(
                    categoryTranslations[widget.categoryModel.name] ??
                        widget.categoryModel.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          productModelList.isEmpty
              ? const Center(
                  child: Text("Không có sản phẩm"),
                )
              : sanPhamCategory(),
        ],
      ),
    );
  }

  Widget sanPhamCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: false,
        itemCount: productModelList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (ctx, index) {
          ProductModel singleProduct = productModelList[index];
          return sanPham(singleProduct);
        },
      ),
    );
  }

  Widget sanPham(ProductModel singleProduct) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          Routes.instance.push(
            widget: ProductDetailScreen(
              singleProduct: singleProduct,
            ),
            context: context,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: sanPham_DanhMuc(singleProduct),
        ),
      ),
    );
  }

  Widget sanPham_DanhMuc(ProductModel singleProduct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            singleProduct.image!,
            height: 100,
            width: 100,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          singleProduct.name.length > 20
              ? singleProduct.name.substring(0, 20) + "..."
              : singleProduct.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Giá: \$${singleProduct.price}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Routes.instance.push(
              widget: ProductDetailScreen(
                singleProduct: singleProduct,
              ),
              context: context,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Mua ngay",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
