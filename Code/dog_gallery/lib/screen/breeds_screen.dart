import 'package:dog_gallery/http/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/breed.dart';
import 'breed_detail_screen.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() {
    return _BreedsState();
  }
}

class _BreedsState extends State<BreedsScreen> {
  int _pageNumber = 1;
  int _pageSize = 30;
  final List<Breed> _breeds = [];
  bool _isRefreshing = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final networkRepository = NetworkRepository();
    final breeds = await networkRepository.getBreeds(
        pageNumber: _pageNumber, pageSize: _pageSize);
    if (!mounted) {
      return;
    }
    setState(() {
      _breeds.addAll(breeds);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  void _loadMore() async {
    if (_isRefreshing || _isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    final networkRepository = NetworkRepository();
    final breeds = await networkRepository.getBreeds(
        pageNumber: _pageNumber + 1, pageSize: _pageSize);
    setState(() {
      _breeds.addAll(breeds);
      _hasMore = breeds.length >= _pageSize;
      _pageNumber++;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dogs'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _refresh();
          },
          child: Column(
            children: [
              _buildGridView(),
              if (_isLoadingMore)
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text("加载中..."),
                ),
              if (!_hasMore)
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text("已加载全部"),
                ),
            ],
          ),
        ));
  }

  Future<void> _refresh() async {
    if (_isRefreshing || _isLoadingMore) return;

    _pageNumber = 1;

    setState(() {
      _isRefreshing = true;
    });

    final networkRepository = NetworkRepository();
    final breeds = await networkRepository.getBreeds(
        pageNumber: _pageNumber, pageSize: _pageSize);
    setState(() {
      _breeds.clear();
      _breeds.addAll(breeds);
      _isRefreshing = false;
    });
  }

  Widget _buildGridView() {
    return Expanded(
        child: MasonryGridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            itemCount: _breeds.length,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemBuilder: (context, index) {
              final breed = _breeds[index];
              return _buildBreedItem(breed);
            }));
  }

  Widget _buildBreedItem(Breed breed) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BreedDetailScreen(breed);
        }));
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(breed.image.url),
              const SizedBox(height: 5),
              _buildBreedName(breed.name),
              _buildIntro(breed.bredFor ?? "")
            ],
          )),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Stack(
          children: [
            Image.network(url),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset("images/fav.png", width: 18, height: 18)),
            )
          ],
        ));
  }

  Widget _buildBreedName(String name) {
    return Text(name,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16));
  }

  Widget _buildIntro(String intro) {
    return Text(intro, style: TextStyle(fontSize: 14));
  }
}
