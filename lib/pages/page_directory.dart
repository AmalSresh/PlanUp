import 'package:cpsc_362_project/pages/survey_page.dart';
import 'package:flutter/material.dart';
import 'package:cpsc_362_project/pages/account_page.dart';
import 'package:cpsc_362_project/pages/home_page.dart';

    class PageDirectory extends StatefulWidget {
       const PageDirectory({Key? key}) : super(key:key);

       @override
      _PageDirectory createState() => _PageDirectory();
    }

    class _PageDirectory extends State<PageDirectory>{

      int _selectedIndex = 0;

      void _navigateBottomBar(int index){
        setState(() {
          _selectedIndex = index;
        });
      }

      List<Widget> get _pages => [
        HomePage(),
        UserAccount(),
        SurveyPage(), // TEMPORARY DELETE LATER
      ];



      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: _pages[_selectedIndex],
           bottomNavigationBar: BottomNavigationBar(
             currentIndex: _selectedIndex,
             onTap: _navigateBottomBar,
             items: [
               BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
               BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
               BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Survey"), //TEMPORARY DELETE LATER
             ],
           ),
        );
      }
    }