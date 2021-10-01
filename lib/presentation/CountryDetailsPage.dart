import 'package:app_cedesistemas/data/model/Country.dart';
import 'package:app_cedesistemas/data/repositories/SharedPreferencesTxRepository.dart';
import 'package:app_cedesistemas/data/repositories/TransactionRepository.dart';
import 'package:flutter/material.dart';

class CountryDetailsPage extends StatelessWidget {

  const CountryDetailsPage({Key? key}) : super(key:key);

  _onSubmitted(String value) async {
    TransactionRepository transactionRepository = SharePreferencesTxRepository();
    transactionRepository.save('COP', value, '${DateTime.now()}');
  }

  @override
  Widget build(BuildContext context) {

    final Country country = ModalRoute.of(context)!.settings.arguments as Country;
    return Scaffold(
      appBar: AppBar(
        title: Text('Información País'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            '${country.name}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Conversion',
            ),
            onSubmitted: _onSubmitted ,
          ),


        ],
      ),
    );
  }
}