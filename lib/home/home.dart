import 'package:flutter/material.dart';
import 'package:smart_home_mobile/home/dashboard.dart';
import 'package:smart_home_mobile/remote/remote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    const HomeDashBoard(),
    const RemoteAccess(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.control_camera_rounded,
            ),
            label: "Remote",
          ),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
