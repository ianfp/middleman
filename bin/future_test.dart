
 costlyQuery() {
  return new Future.immediate("costly");
}

expensiveWork() {
  return new Future.immediate("expensive");
}

lengthyComputation() {
  return new Future.immediate("lengthy");
}

List<String> doTheWork() {
  var f = Futures.wait([
    costlyQuery(),
    expensiveWork(),
    lengthyComputation()
  ]);


}

void main() {
  var result = doTheWork();
}
