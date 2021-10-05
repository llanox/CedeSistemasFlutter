
import 'package:app_cedesistemas/data/repositories/TransactionRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesTxRepository extends TransactionRepository{

  @override
  Future<void> save(String originCurrency, String value, String date) async {
    final preferenceInstance = await SharedPreferences.getInstance();
    preferenceInstance.setString('last-conversion', '{origin_currency:$originCurrency, value:$value, date:$date }');
  }

  @override
  Future<String> getLastConversion() async {
    final preferenceInstance = await SharedPreferences.getInstance();
    return Future<String>.value('${preferenceInstance.getString('last-conversion')}');
  }


}