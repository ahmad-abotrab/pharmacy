class Pair {
  Object first;
  Object second;

  Pair.pairConstractur(dynamic first, dynamic second) {
    this.first = first;
    this.second = second;
  }

  void setFirst(dynamic first) {
    this.first = first;
  }

  void setSecond(dynamic second) {
    this.second = second;
  }

  dynamic getFirst() => this.first;
  dynamic getSecond() => this.second;
}
