class Country {
  final String id;
  final String code;
  final String name;
  final String currencyCode;

  const Country(
      {
        required this.id,
        required this.code,
        required this.name,
        required this.currencyCode
      }
      );

  static final columns = ['id', 'name', 'code', 'currency_code'];
  static final TABLE_NAME = 'countries';

  factory Country.fromMap(Map<String, dynamic> data) {
    return Country(
        id: data[columns[0]],
        code: data[columns[1]],
        name: data[columns[2]],
        currencyCode: data[columns[3]]);
  }

  Map<String, dynamic> toMap() {
    return {'code': code, 'name': name, 'currencyCode': currencyCode};
  }
}
