class Ticker {
  const Ticker();
  Stream<Duration> tick(DateTime checkIn) =>
      Stream.periodic(const Duration(seconds: 1), (_) {
        return DateTime.now().difference(checkIn);
      });
}
