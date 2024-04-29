import 'package:dog_gallery/http/network_repository.dart';
import 'package:dog_gallery/manager/user_manager.dart';
import 'package:dog_gallery/model/dog_image.dart';
import 'package:dog_gallery/screen/login_screen.dart';
import 'package:dog_gallery/widget/loading_dialog.dart';
import 'package:dog_gallery/widget/tips_dialog.dart';
import 'package:flutter/material.dart';

class DogsScreen extends StatefulWidget {
  const DogsScreen({super.key});

  @override
  State<DogsScreen> createState() {
    return _DogsState();
  }
}

class _DogsState extends State<DogsScreen> {
  DogImage? _currentImage;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final repository = NetworkRepository();
    final images = await repository.searchImages(limit: 1);
    if (images.isNotEmpty) {
      setState(() {
        _currentImage = images.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentImage != null) _buildImage(_currentImage!.url),
            Row(
              children: [
                const SizedBox(width: 20),
                _buildIconButton(
                    icon: "fav.png",
                    onPressed: () {
                      if (_currentImage != null) {
                        _addToFavorites(_currentImage!.id);
                      }
                    }),
                const Spacer(),
                _buildIconButton(
                    icon: "like.png",
                    onPressed: () {
                      if (_currentImage != null) {
                        _voteImage(_currentImage!.id, true);
                      }
                    }),
                _buildIconButton(
                    icon: "dislike.png",
                    onPressed: () {
                      if (_currentImage != null) {
                        _voteImage(_currentImage!.id, false);
                      }
                    }),
                const SizedBox(width: 20),
              ],
            )
          ],
        ));
  }

  void _showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        });
  }

  void _hideLoading() {
    Navigator.of(context).pop();
  }

  void _addToFavorites(String imageId) async {
    final isLogin = await UserManager().isLogin;
    if (!isLogin) {
      if (!mounted) return;

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
      return;
    }

    final repository = NetworkRepository();
    _showLoading();
    final result = await repository.addToFavorites(imageId: imageId);
    _hideLoading();
    if (result) {
      _showTip("收藏成功");
      _switchToNextImage();
    } else {
      _showTip("收藏失败");
    }
  }

  void _switchToNextImage() async {
    final repository = NetworkRepository();
    _showLoading();
    final images = await repository.searchImages(limit: 1);
    _hideLoading();
    if (images.isNotEmpty) {
      setState(() {
        _currentImage = images.first;
      });
    }
  }

  void _voteImage(String imageId, bool value) async {
    final isLogin = await UserManager().isLogin;
    if (!isLogin) {
      if (!mounted) return;

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
      return;
    }

    final repository = NetworkRepository();
    _showLoading();
    final result = await repository.voteImage(imageId: imageId, value: value);
    _hideLoading();
    if (result) {
      _showTip(value ? "点赞成功" : "点踩成功");
      _switchToNextImage();
    } else {
      _showTip("操作失败");
    }
  }

  void _showTip(String tips) {
    showDialog(
        context: context,
        builder: (context) {
          return TipsDialog(content: tips);
        });
  }

  Widget _buildImage(String url) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    const iconSize = 25.0;
    return IconButton(
      icon: Image.asset(
        "images/$icon",
        width: iconSize,
        height: iconSize,
        color: Color(0xff999999),
      ),
      onPressed: onPressed,
    );
  }
}
