import 'package:flutter/material.dart';

class TipsDialog extends StatelessWidget {
  final String content;

  const TipsDialog({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const width = 250.0;
    const height = 200.0;

    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: Text(content),
            ),
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
