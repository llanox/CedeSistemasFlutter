import 'package:app_cedesistemas/data/model/Country.dart';

abstract class CountryRepository{
  Future<List<Country>> getAll();
}