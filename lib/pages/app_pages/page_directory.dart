import 'package:cpsc_362_project/pages/app_pages/account_page.dart';
import 'package:cpsc_362_project/pages/app_pages/home_page.dart';
import 'package:flutter/material.dart';

class PageDirectory extends StatefulWidget {
  const PageDirectory({Key? key}) : super(key: key);

  @override
  _PageDirectory createState() => _PageDirectory();
}

class _PageDirectory extends State<PageDirectory> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => [
        const HomePage(),
        const UserAccount(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            icon: Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person_2,
              color: Colors.white,
              size: 30,
            ),
            icon: Icon(
              Icons.person_2,
              color: Colors.white,
              size: 30,
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
