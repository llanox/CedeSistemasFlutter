

abstract class TransactionRepository{
  void save(String originCurrency, String value, String date);
  Future<String> getLastConversion();
}