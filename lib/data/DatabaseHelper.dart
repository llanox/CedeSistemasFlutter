import 'package:app_cedesistemas/data/model/MoneyConversion.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/Country.dart';

class DatabaseHelper{
  //Contructor privado para evitar que se instancie la clase
  DatabaseHelper._();
  static const databaseName = 'countries_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async{
    if(_database == null){
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return openDatabase(
        join(await getDatabasesPath(), databaseName), version: 2, onCreate: (Database db, int version) async{
          await db.execute("CREATE TABLE IF NOT EXISTS countries(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ${Country.columns[1]} TEXT, ${Country.columns[2]} TEXT, ${Country.columns[3]} TEXT)");
          createMoneyConversionsTable(db);
          await db.execute("CREATE TABLE IF NOT EXISTS money_conversions(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ${MoneyConversion.columns[1]} TEXT, ${MoneyConversion.columns[2]} TEXT, ${MoneyConversion.columns[3]} TEXT, ${MoneyConversion.columns[4]} TEXT)");

          await insertCountry(db, ['co','Colombia','COP']);
          await insertCountry(db, ['pe','Perú','PES']);
          await insertCountry(db, ['ve','Venezuela','VEP']);
          await insertCountry(db, ['ar','Argentina','ARS']);
          await insertCountry(db, ['be','Belgica','BEL']);

    },
    onUpgrade:(Database db, int oldVersion, int newVersion) async{
      createMoneyConversionsTable(db);
    }

    );
  }

  Future<void> insertCountry(Database database, List<String> arguments) async {
    await database.execute(
        "INSERT INTO countries('${Country.columns[1]}','${Country.columns[2]}','${Country.columns[3]}') values(?,?,?)",
        arguments
    );
  }

  Future<void> createMoneyConversionsTable(Database db) async {
    await db.execute("CREATE TABLE IF NOT EXISTS money_conversions(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ${MoneyConversion.columns[1]} TEXT, ${MoneyConversion.columns[2]} TEXT, ${MoneyConversion.columns[3]} TEXT, ${MoneyConversion.columns[4]} TEXT)");
  }
}




