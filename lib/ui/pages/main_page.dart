import 'package:charge_me/ui/pages/feedback_page.dart';
import 'package:charge_me/ui/pages/history_page.dart';
import 'package:charge_me/ui/pages/map_page.dart';
import 'package:charge_me/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../core/const/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = <Widget>[
    const MapPage(),
    const HistoryPage(),
    const FeedbackPage(),
    const ProfilePage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomGradientButton(
        onPressed: () {},
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: white,
        notchMargin: 6.0,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 2,
                        width: 36,
                        color: _selectedIndex == 0 ? primary : transparent,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/map.png',
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 0 ? primary : grey,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Карта',
                            style: TextStyle(
                              color: _selectedIndex == 0 ? primary : grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 2,
                        width: 36,
                        color: _selectedIndex == 1 ? primary : transparent,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/clock.png',
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 1 ? primary : grey,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'История',
                            style: TextStyle(
                              color: _selectedIndex == 1 ? primary : grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              SizedBox(),
              SizedBox(),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 2,
                        width: 36,
                        color: _selectedIndex == 2 ? primary : transparent,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/comment.png',
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 2 ? primary : grey,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Связь',
                            style: TextStyle(
                              color: _selectedIndex == 2 ? primary : grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 2,
                        width: 36,
                        color: _selectedIndex == 3 ? primary : transparent,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/user.png',
                            height: 24,
                            width: 24,
                            color: _selectedIndex == 3 ? primary : grey,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Карта',
                            style: TextStyle(
                              color: _selectedIndex == 3 ? primary : grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomGradientButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        height: 64,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFFB7FCEB), // #B7FCEB
              Color(0xFFB0C7EE), // #B0C7EE
              Color(0xFF9A22F9), // #9A22F9
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Image.asset(
          'assets/icons/car.png',
          height: 24,
          width: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
