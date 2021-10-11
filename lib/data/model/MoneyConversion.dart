class MoneyConversion{
  final String? id;
  final double amount;
  final double exchangeRateInUsd;
  final String foreignCountry;
  final DateTime timestamp;

  const MoneyConversion({
    this.id,
    required this.amount,
    required this.exchangeRateInUsd,
    required this.foreignCountry,
    required this.timestamp
});

  static final columns = ['id','amount','exchange_rate','foreign_country','timestamp'];
  static final TABLE_NAME = 'money_conversions';

  Map<String, dynamic> toMap() {
    return {'${columns[1]}': amount.toString(), '${columns[2]}': exchangeRateInUsd.toString(), '${columns[3]}': foreignCountry,'${columns[4]}': timestamp.millisecondsSinceEpoch.toString()};
  }

}