import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app_user/pages/account_screen/account_screen.dart';
import 'package:ecommerce_app_user/pages/cart_screen/cart_screen.dart';
import 'package:ecommerce_app_user/pages/chatbot_screen/chatbot_screen.dart';
import 'package:ecommerce_app_user/pages/favourite_screen/favourite_screen.dart';
import 'package:ecommerce_app_user/pages/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ecommerce_app_user/pages/home_screen/homeScreen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  // final PersistentTabController _controller = PersistentTabController();
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  final bool _hideNavBar = false;
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];

  NavBarStyle _navBarStyle = NavBarStyle.simple;

  List<Widget> _buildScreens() => [
        HomeScreen(),
        CartScreen(),
        OrderScreen(),
        AccountScreen(),
      ];

  Color? _getSecondaryItemColorForSpecificStyles() =>
      _navBarStyle == NavBarStyle.style7 ||
              _navBarStyle == NavBarStyle.style10 ||
              _navBarStyle == NavBarStyle.style15 ||
              _navBarStyle == NavBarStyle.style16 ||
              _navBarStyle == NavBarStyle.style17 ||
              _navBarStyle == NavBarStyle.style18
          ? Colors.white
          : null;

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: _controller.index == 0
                ? Matrix4.identity().scaled(1.2)
                : Matrix4.identity(),
            child: Icon(Icons.home),
            margin: const EdgeInsets.only(right: 3),
          ),
          title: "Home",
          opacity: 1,
          activeColorPrimary: Colors.white,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
          inactiveColorPrimary: Colors.grey,
          // scrollController: _scrollControllers.first,
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: _controller.index == 0
                ? Matrix4.identity().scaled(1.2)
                : Matrix4.identity(),
            margin: const EdgeInsets.only(right: 5),
            child: Icon(Icons.shopping_cart),
          ),
          title: "Giỏ hàng",
          opacity: 1,
          activeColorPrimary: Colors.white,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
          inactiveColorPrimary: Colors.grey,
          // scrollController: _scrollControllers.first,
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: _controller.index == 0
                ? Matrix4.identity().scaled(1.2)
                : Matrix4.identity(),
            child: Icon(Icons.circle),
            margin: const EdgeInsets.only(right: 6),
          ),
          title: "Đơn hàng",
          opacity: 1,
          activeColorPrimary: Colors.white,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
          inactiveColorPrimary: Colors.grey,
          // scrollController: _scrollControllers.first,
        ),
        PersistentBottomNavBarItem(
          icon: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: _controller.index == 0
                ? Matrix4.identity().scaled(1.2)
                : Matrix4.identity(),
            child: Icon(Icons.person),
          ),
          title: "Tôi",

          opacity: 1,
          activeColorPrimary: Colors.white,
          activeColorSecondary: _navBarStyle == NavBarStyle.style7 ||
                  _navBarStyle == NavBarStyle.style10
              ? Colors.white
              : null,
          inactiveColorPrimary: Colors.grey,
          // scrollController: _scrollControllers.first,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            backgroundColor: Colors.grey.shade900,

            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: false,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: false,
            popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
            hideOnScrollSettings: HideOnScrollSettings(
              hideNavBarOnScroll: true,
              scrollControllers: _scrollControllers,
            ),
            padding: const EdgeInsets.only(top: 8, bottom: 5),
            isVisible: !_hideNavBar,
            animationSettings: const NavBarAnimationSettings(
              navBarItemAnimation: ItemAnimationSettings(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimationSettings(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                duration: Duration(milliseconds: 400),
                screenTransitionAnimationType:
                    ScreenTransitionAnimationType.slide,
              ),
              onNavBarHideAnimation: OnHideAnimationSettings(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceInOut,
              ),
            ),
            confineToSafeArea: false,
            navBarHeight: kBottomNavigationBarHeight + 5,
            decoration: NavBarDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
            navBarStyle:
                _navBarStyle, // Choose the nav bar style with this property
          ),
        ),
        floatingActionButton: Padding(
          padding:
              const EdgeInsets.only(bottom: 50), // Dịch lên để tránh BottomBar
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatbotScreen(),
                ),
              );
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
}
