extension IntExtension on int {
  String addPadLeft() {
    return toString().padLeft(3, '0');
  }
}
