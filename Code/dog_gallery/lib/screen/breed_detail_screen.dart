import 'package:dog_gallery/http/network_repository.dart';
import 'package:dog_gallery/model/breed.dart';
import 'package:dog_gallery/theme/theme.dart';
import 'package:flutter/material.dart';

import '../model/dog_image.dart';

class BreedDetailScreen extends StatefulWidget {
  final Breed breed;

  const BreedDetailScreen(this.breed, {super.key});

  @override
  State<BreedDetailScreen> createState() {
    return _BreedDetailScreenState();
  }
}

class _BreedDetailScreenState extends State<BreedDetailScreen> {
  final List<DogImage> _images = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final repository = NetworkRepository();
    final images =
        await repository.searchImages(limit: 10, breedId: widget.breed.id);
    if (mounted) {
      setState(() {
        _images.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text("品种详情"),
        ),
        body: Stack(
          children: [_buildImages(), _buildBottomPanel()],
        ));
  }

  Widget _buildImages() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
          height: 300,
          child: PageView(
            children: _images.map((image) => _buildImage(image)).toList(),
          )),
    );
  }

  Widget _buildImage(DogImage image) {
    return Image.network(
      image.url,
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildBottomPanel() {
    final breed = widget.breed;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Color(0xfff5f5f5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreedName(breed.name),
            _buildLabel("性格"),
            _buildInfo(breed.temperament ?? ""),
            _buildLabel("寿命"),
            _buildInfo(breed.lifeSpan),
            _buildLabel("用途"),
            _buildInfo(breed.bredFor ?? ""),
            const Spacer(),
            _buildButton(),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Widget _buildBreedName(String name) {
    return Padding(
        padding: EdgeInsets.only(top: 15, left: 15),
        child: Text(name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)));
  }

  Widget _buildLabel(String label) {
    return Padding(
        padding: EdgeInsets.only(left: 15, top: 10),
        child: Text(label,
            style: TextStyle(fontSize: 18, color: Color(0xff333333))));
  }

  Widget _buildInfo(String info) {
    return Padding(
        padding: EdgeInsets.only(left: 15, top: 10),
        child: Text(info,
            style: TextStyle(fontSize: 18, color: Color(0xff333333))));
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        onPressed: () {},
        child: Text("了解更多"),
      ),
    );
  }
}
