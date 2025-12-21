import 'dart:io';

import 'package:ecommerce_app_admin/constants/constants.dart';
import 'package:ecommerce_app_admin/firebase/firebase_firestore/firebase_firestore_support.dart';
import 'package:ecommerce_app_admin/models/category_model/category_model.dart';
import 'package:ecommerce_app_admin/models/order_model/order_model.dart';
import 'package:ecommerce_app_admin/models/product_model/product_model.dart';
import 'package:ecommerce_app_admin/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];
  List<ProductModel> _productsList = [];
  List<OrderModel> _completedOrderList = [];
  List<OrderModel> _cancelOrderList = [];
  List<OrderModel> _pendingOrderList = [];
  List<OrderModel> _deliveryOrderList = [];

  double _totalEarning = 0.0;

  Future<void> getUserListFunc() async {
    _userList = await FirebaseFirestoreSupport.instance.getUserList();
  }

  Future<void> getCompletedOrder() async {
    notifyListeners();
    _completedOrderList =
        await FirebaseFirestoreSupport.instance.getCompletedOrder();

    calculateTotalEarning();
    print("Danh sach complete:  $_completedOrderList");

    notifyListeners();
  }

  Future<void> getCancelOrder() async {
    notifyListeners();
    _cancelOrderList = await FirebaseFirestoreSupport.instance.getCancelOrder();

    notifyListeners();
  }

  Future<void> getDeliveryOrder() async {
    notifyListeners();
    _deliveryOrderList =
        await FirebaseFirestoreSupport.instance.getDeliveryOrder();

    notifyListeners();
  }

  Future<void> getPendingOrder() async {
    notifyListeners();
    _pendingOrderList =
        await FirebaseFirestoreSupport.instance.getPendingOrder();

    print("Danh sach pendingpending:  $_pendingOrderList");
    notifyListeners();
  }

  void calculateTotalEarning() {
    notifyListeners();
    _totalEarning =
        _completedOrderList.fold(0.0, (sum, item) => sum + item.totalPrice);
    notifyListeners();
  }

  Future<void> getCategoriesListFunc() async {
    _categoriesList = await FirebaseFirestoreSupport.instance.getCategories();
  }

  // User
  Future<void> deleteUserFromFirebase(UserModel userModel) async {
    notifyListeners();

    String value =
        await FirebaseFirestoreSupport.instance.deleteSingleUser(userModel.id);
    if (value.contains("Xóa thành công")) {
      _userList.remove(userModel);
      showMessage("Xóa thành công");
    }

    notifyListeners();
  }

  List<UserModel> get getUserList => _userList;
  List<CategoryModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProducts => _productsList;
  List<OrderModel> get getCompletedOrderList => _completedOrderList;
  List<OrderModel> get getCancelOrderList => _cancelOrderList;
  List<OrderModel> get getPendingOrderList => _pendingOrderList;
  List<OrderModel> get getDeliveryOrderList => _deliveryOrderList;
  double get getTotalEarning => _totalEarning;

  Future<void> callBackFunction() async {
    await Future.wait([
      getUserListFunc(),
      getCategoriesListFunc(),
      getProduct(),
      getCompletedOrder(),
      getCancelOrder(),
      getPendingOrder(),
      getDeliveryOrder()
    ]);
    // await getUserListFunc();
    // await getCategoriesListFunc();
    // await getProduct();
    // await getCompletedOrder();
    // await getCancelOrder();
    // await getPendingOrder();
    // await getDeliveryOrder();
  }

  void updateUserList(int index, UserModel userModel) async {
    await FirebaseFirestoreSupport.instance.updateUser(userModel);

    _userList[index] = userModel;
    notifyListeners();
  }

  // Category
  Future<void> deleteCategoryFromFirebase(CategoryModel categoryModel) async {
    notifyListeners();

    String value = await FirebaseFirestoreSupport.instance
        .deleteSingleCategory(categoryModel.id);
    if (value.contains("Xóa thành công")) {
      _categoriesList.remove(categoryModel);
      showMessage("Xóa thành công");
    }

    notifyListeners();
  }

  void updateCategoryList(int index, CategoryModel categoryModel) async {
    await FirebaseFirestoreSupport.instance.updateSingleCategory(categoryModel);

    _categoriesList[index] = categoryModel;
    notifyListeners();
  }

  void addCategory(File image, String name) async {
    CategoryModel categoryModel =
        await FirebaseFirestoreSupport.instance.addSingleCategory(image, name);

    _categoriesList.add(categoryModel);
    notifyListeners();
  }

  // Product
  Future<void> getProduct() async {
    _productsList = await FirebaseFirestoreSupport.instance.getProducts();
    notifyListeners();
  }

  Future<void> deleteProductFromFirebase(ProductModel productModel) async {
    String value = await FirebaseFirestoreSupport.instance
        .deleteProduct(productModel.categoryId, productModel.id);
    if (value.contains("Xóa thành công")) {
      _productsList.remove(productModel);
      showMessage("Xóa thành công");
    }

    notifyListeners();
  }

  void updateProductList(int index, ProductModel productModel) async {
    await FirebaseFirestoreSupport.instance.updateSingleProduct(productModel);

    _productsList[index] = productModel;
    notifyListeners();
  }

  void addProduct(
    File image,
    String name,
    String categoryId,
    String price,
    String description,
  ) async {
    ProductModel productModel = await FirebaseFirestoreSupport.instance
        .addSingleProduct(image, name, categoryId, price, description);

    _productsList.add(productModel);
    notifyListeners();
  }

  void updatePendingOrder(OrderModel order) {
    notifyListeners();

    _deliveryOrderList.add(order);
    _pendingOrderList.remove(order);
    notifyListeners();
    showMessage("Đã gửi bên vận chuyển");
  }

  // TODO: After
  void updateCancelPendingOrder(OrderModel order) {
    notifyListeners();

    _cancelOrderList.add(order);
    _pendingOrderList.remove(order);
    showMessage("Hủy thành công");
    notifyListeners();
  }

  // TODO: After
  void updateCancelDeliveryOrder(OrderModel order) {
    notifyListeners();

    _cancelOrderList.add(order);
    _pendingOrderList.remove(order);
    showMessage("Hủy thành công");

    notifyListeners();
  }
}
