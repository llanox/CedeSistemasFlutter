import 'package:app_cedesistemas/data/model/MoneyConversion.dart';
import 'package:app_cedesistemas/data/repositories/MoneyConversionRepository.dart';
import 'package:sqflite/sqflite.dart';

import '../DatabaseHelper.dart';

class MoneyConversionRepositoryImpl extends MoneyConversionRepository {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Future<bool> save(MoneyConversion conversion) async {
    Database? db = await _databaseHelper.database;
    int? row = await db?.insert(MoneyConversion.TABLE_NAME, conversion.toMap());
    if(row !=null && row > 0){
      return Future<bool>.value(true);
    }else{
      return Future<bool>.value(false);
    }
  }


}