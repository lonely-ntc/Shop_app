import 'package:ecommerce_app_admin/constants/routes.dart';
import 'package:ecommerce_app_admin/provider/app_provider.dart';
import 'package:ecommerce_app_admin/screens/categories_screen/categories_screen.dart';
import 'package:ecommerce_app_admin/screens/home_screen/widgets/single_item.dart';
import 'package:ecommerce_app_admin/screens/order_list/order_list.dart';
import 'package:ecommerce_app_admin/screens/product_view/product_view.dart';
import 'package:ecommerce_app_admin/screens/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    await appProvider.callBackFunction();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
              ),
              const SizedBox(height: 12),
              const Text(
                "Trung Hoang",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                "TrungHoang2004@gmail.com",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(top: 12),
                crossAxisCount: 2,
                children: [
                  SingleItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getUserListFunc().toString() == null
                        ? appProvider.getUserListFunc().toString()
                        : appProvider.getUserList.length.toString(),
                    subtitle: "Người dùng",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const UserScreen(), context: context);
                    },
                  ),
                  SingleItem(
                    title:
                        // ignore: unnecessary_null_comparison
                        appProvider.getCategoriesListFunc().toString() != null
                            ? appProvider.getCategoriesList.length.toString()
                            : appProvider.getCategoriesListFunc().toString(),
                    // title: appProvider.getCategoriesListFunc().toString(),

                    subtitle: "Danh mục",
                    onPressed: () {
                      Routes.instance.push(
                          widget: const CategoriesScreen(), context: context);
                    },
                  ),
                  SingleItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getProduct().toString() == null
                        ? appProvider.getProduct().toString()
                        : appProvider.getProducts.length.toString(),
                    // title: appProvider.getProduct().toString(),
                    subtitle: "Sản phẩm",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const ProductView(), context: context);
                    },
                  ),
                  SingleItem(
                    // ${appProvider.getTotalEarning}
                    title: "\$${appProvider.getTotalEarning}",
                    subtitle: "Tổng tiền",
                    onPressed: () {},
                  ),
                  SingleItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getPendingOrder().toString() != null
                        ? appProvider.getPendingOrderList.length.toString()
                        : appProvider.getPendingOrder().toString(),
                    subtitle: "Đơn chờ xử lý",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "đang xử lý",
                            orderModelList: appProvider.getPendingOrderList,
                          ),
                          context: context);
                    },
                  ),
                  SingleItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getDeliveryOrder().toString() == null
                        ? appProvider.getDeliveryOrder().toString()
                        : appProvider.getDeliveryOrderList.length.toString(),
                    subtitle: "Đơn giao nhận",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "giao nhận",
                            orderModelList: appProvider.getDeliveryOrderList,
                          ),
                          context: context);
                    },
                  ),
                  SingleItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getCancelOrder().toString() == null
                        ? appProvider.getCancelOrder().toString()
                        : appProvider.getCancelOrderList.length.toString(),
                    subtitle: "Đơn từ chối",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "từ chối",
                            orderModelList: appProvider.getCancelOrderList,
                          ),
                          context: context);
                    },
                  ),
                  SingleItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getCompletedOrder().toString() == null
                        ? appProvider.getCompletedOrder().toString()
                        : appProvider.getCompletedOrderList.length.toString(),
                    subtitle: "Đơn đã xác nhận",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "xác nhận",
                            orderModelList: appProvider.getCompletedOrderList,
                          ),
                          context: context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
