import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _urls = [
    "https://10wallpaper.com/wallpaper/1920x1080/1512/Ferocious_lion-Animal_Photo_HD_Wallpaper_1920x1080.jpg",
    "https://img1.baidu.com/it/u=903829763,2925435307&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=1751808597,1886318187&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "https://img0.baidu.com/it/u=3476293439,478517026&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fss2.meipian.me%2Fusers%2F598964%2F4e90446aa2f648cb931e0db1d210c3b0.jpg%3Fmeipian-raw%2Fbucket%2Fivwen%2Fkey%2FdXNlcnMvNTk4OTY0LzRlOTA0NDZhYTJmNjQ4Y2I5MzFlMGRiMWQyMTBjM2IwLmpwZw%3D%3D%2Fsign%2F91f37d176c8e2802169648c80539c5d3.jpg&refer=http%3A%2F%2Fss2.meipian.me&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1712323627&t=93b1788036d3d43f91c525ceca10ff80"
  ];
  final _contoller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _contoller.animateTo(300,
              duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
        },
      ),
      body: SingleChildScrollView(
        controller: _contoller,
        child: Column(
          children: List.generate(
              _urls.length,
              (index) => Card(
                  margin: EdgeInsets.all(15),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(_urls[index]))),
        ),
      ),
    );
  }
}
