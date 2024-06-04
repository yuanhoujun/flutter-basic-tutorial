extension IntX on int {
  bool get isEven1 {
    return this % 2 == 0;
  }
}

// extension IntX2 on int {
//   bool get isEven1 {
//     return this % 2 == 0;
//   }
// }

bool isEven(int x) {
  return x % 2 == 0;
}