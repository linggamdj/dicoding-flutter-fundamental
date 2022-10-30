import 'package:flutter/material.dart';
import 'package:restaurant_app/commons/style.dart';
import 'package:restaurant_app/pages/favorite_page.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/pages/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const MainPage(),
    const FavoritePage(),
    const SettingPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(context);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryColor,
              spreadRadius: 0,
              blurRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            selectedItemColor: primaryColor,
            currentIndex: _bottomNavIndex,
            items: _bottomNavBarItems,
            onTap: _onBottomNavTapped,
          ),
        ),
      ),
    );
  }
}
