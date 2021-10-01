import 'package:app_cedesistemas/data/repositories/CountryRepository.dart';
import 'package:app_cedesistemas/data/repositories/CountryRepositoryImpl.dart';
import 'package:app_cedesistemas/data/repositories/SharedPreferencesTxRepository.dart';
import 'package:app_cedesistemas/data/repositories/TransactionRepository.dart';
import 'package:flutter/material.dart';
import 'CountryDetailsPage.dart';


class LatamAInfoAppStatefulWidget extends StatefulWidget {
  const LatamAInfoAppStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LatamAInfoApp();
}

class LatamAInfoApp extends State<LatamAInfoAppStatefulWidget> {
  int _selectedIndex = 0;
  String _lastUpdate = '';
  CountryRepository _countryRepository = CountryRepositoryImpl();
  TransactionRepository transactionRepository = SharePreferencesTxRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$_lastUpdate'),
          backgroundColor: Colors.lightGreen,
        ),
        body: ListView.builder(
          itemCount: _countryRepository.getAll().length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: Image.network(
                  'https://www.countryflags.io/${_countryRepository.getAll()[index].code}/flat/64.png',
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Text('😢');
                  },
                ),
                title: Text(_countryRepository.getAll()[index].name),
                subtitle: Text(_countryRepository.getAll()[index].currencyCode),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => const CountryDetailsPage(),
                          settings: RouteSettings(
                            arguments: _countryRepository.getAll()[index],
                          )
                      )
                  );
                  setState(() {
                    _selectedIndex = index;
                     transactionRepository.getLastConversion().then((value) => _lastUpdate = value);
                  });
                });
          },
        ));
  }
}