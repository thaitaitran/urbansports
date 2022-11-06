class Ticker {
  const Ticker();
  Stream<int> tick() => Stream.periodic(const Duration(seconds: 1), (x) {
        return x;
      });
}
