import 'dart:math';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'reusable_card.dart';

const String url =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/';


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  String bit = cryptoList[0];
  String eth = cryptoList[1];
  String ltc = cryptoList[2];
  double value1;
  double value2;
  double value3;
  List<Widget> textList = [];

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
          updateUI(value);
         // print(url+selectedCurrency);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void updateUI (String currType) async {
    try{
      CoinData coinValue1 = CoinData(url: url+bit+currType);
      CoinData coinValue2 = CoinData(url: url+eth+currType);
      CoinData coinValue3 = CoinData(url: url+ltc+currType);
      var data1 = await coinValue1.getData();
      var data2 = await coinValue2.getData();
      var data3 = await coinValue3.getData();
      var decodedData1 = jsonDecode(data1);
      var decodedData2 = jsonDecode(data2);
      var decodedData3 = jsonDecode(data3);
      setState(() {
        selectedCurrency = currType;
        value1 = decodedData1['last'];
        value2 = decodedData2['last'];
        value3 = decodedData3['last'];
      });
    }catch(e){
      print(e);
      value1 = 0.0;
      value2 = 0.0;
      value3 = 0.0;
      selectedCurrency = 'error';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: reusableCard(value: value1, selectedCurrency: selectedCurrency,type:bit),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: reusableCard(value: value2, selectedCurrency: selectedCurrency,type:eth),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: reusableCard(value: value3, selectedCurrency: selectedCurrency,type:ltc),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

