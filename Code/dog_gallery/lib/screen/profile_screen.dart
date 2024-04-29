import 'package:dog_gallery/http/network_repository.dart';
import 'package:dog_gallery/manager/user_manager.dart';
import 'package:dog_gallery/screen/login_screen.dart';
import 'package:dog_gallery/theme/theme.dart';
import 'package:flutter/material.dart';

import '../model/dog_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileState();
  }
}

enum ProfileTab { favorites, likes }

class _ProfileState extends State<ProfileScreen> {
  ProfileTab _currentTab = ProfileTab.favorites;
  final List<DogImage> _favoriteImages = [];
  final List<DogImage> _likeImages = [];
  bool _isLogin = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final networkRepository = NetworkRepository();
    final favoriteImages = await networkRepository.getFavoriteImage();
    _favoriteImages.addAll(favoriteImages.map((e) => e.image).toList());
    final voteImages = await networkRepository.getVoteImage();
    _likeImages.addAll(voteImages
        .where((voteImage) => voteImage.value == 1)
        .map((e) => e.image)
        .toList());
    _isLogin = await UserManager().isLogin;
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dogs'),
          actions: [
            if (_isLogin)
              TextButton(
                  onPressed: () {
                    _logout();
                  },
                  child: Text("退出登录"))
          ],
        ),
        body: _isLogin ? _buildLoginView() : _buildAnonView());
  }

  void _logout() async {
    await UserManager().clearUserInfo();
    if (!mounted) return;
    
    setState(() {
      _isLogin = false;
    });
  }

  void _goToLogin() async {
    final isLogin =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    })) as bool?;
    if (isLogin == true) {
      setState(() {
        _isLogin = true;
      });
    }
  }

  SizedBox _buildLoginView() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("images/avatar.jpg"),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildUserItemView(label: "图片", value: "121"),
              _buildUserItemView(label: "粉丝", value: "12k"),
              _buildUserItemView(label: "关注", value: "403")
            ],
          ),
          const SizedBox(height: 20),
          _buildTabBar(),
          Expanded(
              child: IndexedStack(
            index: _currentTab.index,
            children: [_buildFavoriteImages(), _buildLikeImages()],
          ))
        ],
      ),
    );
  }

  Widget _buildAnonView() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: loginButtonBgColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              _goToLogin();
            },
            child: Text("登录")),
      ),
    );
  }

  Widget _buildFavoriteImages() {
    return ListView.builder(
        itemCount: _favoriteImages.length,
        itemBuilder: (context, index) {
          final image = _favoriteImages[index];
          return _buildImageItem(image: image, space: index <= 0 ? 0 : 15);
        });
  }

  Widget _buildLikeImages() {
    return ListView.builder(
        itemCount: _likeImages.length,
        itemBuilder: (context, index) {
          final image = _likeImages[index];
          return _buildImageItem(image: image, space: index <= 0 ? 0 : 15);
        });
  }

  Widget _buildImageItem({required DogImage image, required int space}) {
    return Padding(
        padding: EdgeInsets.only(top: space.toDouble()),
        child: Image.network(image.url,
            fit: BoxFit.cover, width: double.infinity, height: 300));
  }

  Widget _buildTabBar() {
    return Container(
        height: 40,
        color: Color(0xfff5f5f5),
        child: Row(
          children: [
            _buildTabBarItem(
                text: "121 收藏",
                isActive: true,
                onTap: () {
                  _switchTab(ProfileTab.favorites);
                }),
            _buildTabBarItem(
                text: "231 喜欢",
                isActive: false,
                onTap: () {
                  _switchTab(ProfileTab.likes);
                }),
          ],
        ));
  }

  void _switchTab(ProfileTab tab) {
    if (tab == _currentTab) return;

    setState(() {
      _currentTab = tab;
    });
  }

  Widget _buildTabBarItem(
      {required String text,
      required bool isActive,
      required VoidCallback onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(text,
                style: TextStyle(
                  fontSize: 14,
                  color: isActive ? Colors.black87 : Colors.grey[600],
                ))));
  }

  Widget _buildUserItemView({required String label, required String value}) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: userItemValueColor)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: userItemLabelColor))
      ],
    );
  }
}
