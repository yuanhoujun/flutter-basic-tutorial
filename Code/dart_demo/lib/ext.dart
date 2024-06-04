class Pig {
  String name;
  int age;

  Pig(this.name, this.age);

  Pig.create() : this("Tom", 3);

  void bark() {}
}

class A {
  final int x;
  final int y;

  A(this.x, this.y);

  A.fromJson(Map<String, dynamic> json)
      : this.x = json["x"],
        this.y = json["y"] {
    print("A.fromJson");
  }
}

// 调用父类参数
class A1 extends A {
  final int z;

  A1(int x, int y, this.z) : super(x, y);
  // A1(super.x, super.y, this.z);
}

class A2 extends A {
  // A2.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  A2.fromJson(super.data) : super.fromJson();
}

// 初始化列表
class A3 extends A {
  final int a;
  final int b;

  A3.fromJson(Map<String, dynamic> json)
      : a = json["x"],
        b = f(),
        super.fromJson(json) {
    print("A3.fromJson");
  }
}

int f() {
  print("初始化列表");
  return 3;
}

/// 问题：请问初始化列表、父类构造器、子类构造器的执行顺序是什么，如何证明？

// 多个构造函数
class B {
  final int x;
  final int y;

  B(this.x, this.y);

  // 请问这是为什么？
  // B() : this(0, 0);

  B.create() : this(0, 0);
}

class Person {
  String name;

  Person(this.name);

  String greet() => "Hello, $name";
}

class Student implements Person {
  @override
  String greet() {
    // TODO: implement greet
    throw UnimplementedError();
  }

  @override
  String get name => throw UnimplementedError();

  @override
  set name(String _name) {
    // TODO: implement name
  }
}

class Student2 extends Person {
  Student2(super.name);
}

// 接口类不能在库的外面继承
interface class Animal {
  void eat() {}
}

class Cat extends Animal {
  @override
  void eat() {
    // TODO: implement eat
  }
}

abstract class Plant {
  void grow();
}

class Tree extends Plant {
  @override
  void grow() {
    // TODO: implement grow
  }
  
}

class Tree1 implements Plant {
  @override
  void grow() {
    // TODO: implement grow
  }
  
}

void main(List<String> args) {
  // final pig = Pig.create();
  final a3 = A3.fromJson({"x": 3, "y": 4});
}
