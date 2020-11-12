import 'package:flutter/material.dart';
import 'package:flutter_app_01/ui/cart/CartPage.dart';
import 'package:flutter_app_01/ui/home/HomePage.dart';
import 'package:flutter_app_01/ui/me/MePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  List<BottomNavigationBarItem> _bottomItems = List<BottomNavigationBarItem>();
  List<Widget> _pages = List<Widget>();
  int _currentIndex = 0;

  // PageController _pageController = PageController();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    initItems();
    _controller = TabController(length: _bottomItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: _bottomItems,
        currentIndex: _currentIndex,
        onTap: (int index) {
          _controller.animateTo(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      // body: _pages[_currentIndex],
      // body: PageView.builder(
      //   controller: _pageController,
      //   onPageChanged: _pageChanged,
      //   physics: NeverScrollableScrollPhysics(),
      //   itemCount: _pages.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return _pages[_currentIndex];
      //   },
      // ),
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: _pages,
      // ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _pages,
      ),
    );
  }

  // _pageChanged(int index) {
  //   print("_pageChanged=$index");
  // }

  void initItems() {
    var _home = BottomNavigationBarItem(
      label: "HomePage",
      icon: Icon(
        Icons.home,
        // color: _currentColor,
      ),
    );
    _bottomItems.add(_home);

    var _cart = BottomNavigationBarItem(
      label: "CartPage",
      icon: Icon(
        Icons.shopping_cart,
        // color: _currentColor,
      ),
    );
    _bottomItems.add(_cart);

    var _me = BottomNavigationBarItem(
      label: "MePage",
      icon: Icon(
        Icons.perm_identity,
        // color: _currentColor,
      ),
    );
    _bottomItems.add(_me);

    _pages.add(HomePage());
    _pages.add(CartPage());
    _pages.add(MePage());
  }
}
