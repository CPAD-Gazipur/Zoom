import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/screens.dart';
import 'package:zoom_clone/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  List<Widget> pages = [
    const MeetingScreen(),
    const MeetingHistoryScreen(),
    const Center(
      child: Text('Contacts'),
    ),
    const SettingsScreen(),
  ];

  List<String> appBarTitles = [
    'Meet & Chat',
    'Meetings',
    'Contacts',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(appBarTitles[_currentPage]),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _currentPage,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: "Meet & Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: "Meetings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
