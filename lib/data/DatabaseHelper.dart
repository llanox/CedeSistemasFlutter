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
        join(await getDatabasesPath(), databaseName), version: 1, onCreate: (Database db, int version) async{
          await db.execute("CREATE TABLE IF NOT EXISTS countries(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ${Country.columns[1]} TEXT, ${Country.columns[2]} TEXT, ${Country.columns[3]} TEXT)");
          await insertCountry(db, ['co','Colombia','COP']);
          await insertCountry(db, ['pe','Perú','PES']);
          await insertCountry(db, ['ve','Venezuela','VEP']);
          await insertCountry(db, ['ar','Argentina','ARS']);
    } );
  }

  Future<void> insertCountry(Database database, List<String> arguments) async {
    await database.execute(
        "INSERT INTO countries('${Country.columns[1]}','${Country.columns[2]}','${Country.columns[3]}') values(?,?,?)",
        arguments
    );

  }
}
