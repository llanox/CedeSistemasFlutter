import 'package:app_cedesistemas/data/model/Country.dart';
import 'package:flutter/material.dart';

class CountryDetailsPage extends StatelessWidget {
  const CountryDetailsPage({Key? key}) : super(key: key);

  void _onBuyCurrency() {}

  @override
  Widget build(BuildContext context) {
    final Country country =
        ModalRoute.of(context)!.settings.arguments as Country;
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Information'),
      ),
      body:
      SingleChildScrollView(
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
            Padding( padding: EdgeInsets.all(12),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child:
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '${country.currencyCode}'
                  ),
                ),
                ),
                Icon(Icons.repeat, size:32),
                Expanded(
                  child:
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'USD'
                    ),
                  ),
                ),

              ],
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
