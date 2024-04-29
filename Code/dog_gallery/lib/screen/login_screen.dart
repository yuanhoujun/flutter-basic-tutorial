import 'package:dog_gallery/manager/user_manager.dart';
import 'package:dog_gallery/model/constant.dart';
import 'package:dog_gallery/theme/theme.dart';
import 'package:dog_gallery/widget/loading_dialog.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: loginBgColor,
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(height: 10),
                _buildTextField(
                    icon: Icons.email,
                    placeholder: "邮箱",
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }),
                const SizedBox(height: 15),
                _buildTextField(
                    icon: Icons.lock,
                    placeholder: "密码",
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    }),
                const SizedBox(height: 15),
                _buildLoginButton()
              ],
            )));
  }

  Widget _buildTitle() {
    return const Text("登录",
        style: TextStyle(fontSize: 18, color: Color(0xff333333)));
  }

  Widget _buildTextField(
      {required IconData icon,
      required String placeholder,
      required Function(String) onChanged}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: placeholder,
            filled: true,
            fillColor: loginInputFilledColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildLoginButton() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: loginButtonBgColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: _email != null && _password != null
                ? () {
                    _login();
                  }
                : null,
            child: const Text("登录")),
      ),
    );
  }

  void _login() async {
    _showLoading();
    // 这里模拟登录操作
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pop(context);
    }

    await UserManager().setUserId(userId);

    // onActivityResult
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  void _showLoading() {
    showDialog(
        context: context,
        builder: (context) {
          return LoadingDialog();
        });
  }
}
