void f(int x, int y) {}

int f1(int z, int w, {required int x, required int y}) {
  return x + y;
}

void f2(int x, int y, [int z = 0]) {}

typedef AddedBy = int Function(int);
typedef IntList = List<int>;

int f3(int x, AddedBy addedBy) {
  return addedBy(x);
}

int f4(int x) {
  return x + 1;
}

// 生成器
Iterable<int> f5(int x) sync* {
  int k = 0;
  while (k < x) {
    k++;
    yield k;
  }
}

Stream<int> f6(int x) async* {
  int k = 0;
  while (k < x) {
    k++;
    yield k;

    await Future.delayed(Duration(seconds: 1));
  }
}

// record
(int, int) f7() {
  return (1, 2);
}

({int x, int y}) f8() {
  return (x: 1, y: 2);
}

void main(List<String> args) {
  // f1(1, 2, x: 3, y: 4);
  // f2(1, 2, 3);

  // final val = f3(1, f4);
  // print(val);

  // final val = f5(5);
  // print(val);

  // final stream = f6(5);
  // stream.listen((event) {
  //   print(event);
  // });
  final val = f8();
  print(val.x);
}
