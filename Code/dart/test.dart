import 'ext.dart';

void main(List<String> args) {
  // int x = 3;
  var x = 3;
  final y = 3;
  x = 4;
  dynamic z = 3;
  print("z: ${z.runtimeType}");
  z = "Hello";
  print("Hello, world, ${x.runtimeType}, $z => ${z.runtimeType}");
  // List, Set, LinkedList
  final List<int> list = [1, 2, 3];
  // Float, double
  final double pi = 3.14;
  // Long, int
  final int big = 1000000000;

  final dog = Dog.fromJson({"name": "Tom", "age": 3});
  final instance = Dog._instance;
}

// Dart是一门纯面向对象的编程语言
class Dog {
  String name;
  int age;

  static Dog _instance = Dog("Tom", 3);

  Dog(this.name, this.age);

  Dog.fromJson(Map<String, dynamic> json) : this(json["name"], json["age"]);

  factory Dog.create() {
    return _instance;
  }

  void bark() {
    print("${this.name} is barking");
  }
}

class Cat1 implements Animal {
  @override
  void eat() {
    // TODO: implement eat
  }
}