
import 'package:app_cedesistemas/data/model/Country.dart';
import 'CountryRepository.dart';

class CountryRepositoryImpl extends CountryRepository{
  @override
  List getAll() {
     return <Country>[
      Country('co','Colombia','COP'),
      Country('pe','Perú','PES'),
      Country('ve','Venezuela','VEP'),
      Country('ar','Argentina','ARS'),
    ];
  }


}