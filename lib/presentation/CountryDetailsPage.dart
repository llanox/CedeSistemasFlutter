import 'package:app_cedesistemas/data/model/Country.dart';
import 'package:app_cedesistemas/data/model/MoneyConversion.dart';
import 'package:app_cedesistemas/data/repositories/MoneyConversionRepository.dart';
import 'package:app_cedesistemas/data/repositories/MoneyConversionRepositoryImpl.dart';
import 'package:flutter/material.dart';

class CountryDetailsPageStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CountryDetailsPage();
}

class CountryDetailsPage extends State<CountryDetailsPageStatefulWidget> {
  late final _formKey;
  double exchangeRate = 0.5;
  double valueUsd = 0;
  double _amountForeignCurrency = 0;

  MoneyConversionRepository _conversionRepository = MoneyConversionRepositoryImpl();

  String? amountValidator(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'please, type the money';
    }
    final number = num.tryParse(value);
    if (number == null) {
      return 'wrong value';
    }
    return null;
  }

  void _onForeignCurrencyChanged(String value) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        valueUsd = double.parse(value) * exchangeRate;
      });
    }
  }

  void onSaveAmount(String? amount) {
    if(amount!=null){
      _amountForeignCurrency = double.parse(amount);
    }
  }


  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  void _onBuyCurrency() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final conversion = MoneyConversion(amount: _amountForeignCurrency, exchangeRateInUsd: exchangeRate, foreignCountry: 'CO', timestamp: DateTime.now());
      _conversionRepository.save(conversion);
    } else {
      print('wrong values in the field');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Country country =
        ModalRoute.of(context)!.settings.arguments as Country;
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Information'),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                '${country.name}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Image.network('https://picsum.photos/250'),
            Padding(
              padding: EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: amountValidator,
                        onChanged: _onForeignCurrencyChanged,
                        onSaved: onSaveAmount,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '${country.currencyCode}'),
                      ),
                    ),
                    Icon(Icons.repeat, size: 32),
                    Expanded(
                      child: Text('$valueUsd')
                    ),
                  ],
                ),
              ),
            ),
          ])),
      bottomSheet: Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _onBuyCurrency,
                  child: Text('Buy (${country.currencyCode})')))),
    );
  }
}
