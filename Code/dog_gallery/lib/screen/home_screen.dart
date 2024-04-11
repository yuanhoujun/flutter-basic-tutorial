import 'package:dog_gallery/screen/dogs_screen.dart';
import 'package:dog_gallery/screen/profile_screen.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'breeds_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

enum HomeTab {
  dogs,
  breeds,
  profile,
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTab _currentTab = HomeTab.dogs;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _currentTab.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              _currentTab = HomeTab.values[value];
            });
          },
          children: [DogsScreen(), BreedsScreen(), ProfileScreen()],
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          children: [
            _HomeTabButton(
                icon: "home.png",
                label: "首页",
                value: HomeTab.dogs,
                groupValue: _currentTab,
                onTap: () {
                  _switchTab(HomeTab.dogs);
                }),
            _HomeTabButton(
                icon: "breed.png",
                label: "品种",
                value: HomeTab.breeds,
                groupValue: _currentTab,
                onTap: () {
                  _switchTab(HomeTab.breeds);
                }),
            _HomeTabButton(
                icon: "mine.png",
                label: "品种",
                value: HomeTab.profile,
                groupValue: _currentTab,
                onTap: () {
                  _switchTab(HomeTab.profile);
                })
          ],
        )));
  }

  void _switchTab(HomeTab tab) {
    if (tab == _currentTab) return;

    _controller.animateToPage(tab.index,
        duration: Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }
}

class _HomeTabButton extends StatelessWidget {
  final String icon;
  final String label;
  final HomeTab value;
  final HomeTab groupValue;
  final VoidCallback onTap;

  const _HomeTabButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final color = isSelected ? tabActiveColor : tabInactiveColor;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset("images/$icon", width: 25, height: 25, color: color),
            Text(label, style: TextStyle(color: color, fontSize: 14))
          ],
        ),
      ),
    );
  }
}
