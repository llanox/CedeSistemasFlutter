import 'package:app_cedesistemas/data/DatabaseHelper.dart';
import 'package:app_cedesistemas/data/model/Country.dart';
import 'package:sqflite/sqflite.dart';
import 'CountryRepository.dart';

class CountryRepositoryImpl extends CountryRepository {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Future<List<Country>> getAll() async {
    Database? db = await _databaseHelper.database;
    List<Map<String, dynamic>>? result = await db?.query(Country.TABLE_NAME);

    return result != null
        ? List.generate(result.length, (index) {
            return Country(
                id: result[index][Country.columns[0]].toString(),
                code: result[index][Country.columns[1]],
                name: result[index][Country.columns[2]],
                currencyCode: result[index][Country.columns[3]]);
          })
        : List<Country>.empty();
  }
}
