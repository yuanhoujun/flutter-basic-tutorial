import 'inx.dart';

class Person {}

mixin Drive on Driver {
  void drive() {
    print("Drive");
  }
}

class Driver {}

class OldDriver extends Driver with Drive {}

class Animal {
  void eat() {
    print("Eat");
  }
}

class Dog with Bite {}

class Bird with Fly {}

class Fish with Swim {}

class Shark with Bite, Swim {}

mixin Bite {
  void bite() {
    print("Bite");
  }
}

mixin Swim {
  void swim() {
    print("Swim");
  }
}

mixin Fly {
  void fly() {
    print("Fly");
  }
}

void main(List<String> args) {
  int x = 4;
  print("isEven: ${x.isEven1}");
}
