import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCrypto = 'USD';

  List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> source) {
    List<DropdownMenuItem<String>> result = [];
    for (String str in source) {
      result.add(
        DropdownMenuItem(
          child: Text(str),
          value: str,
        ),
      );
    }
    return result;
  }

  List<Text> getPickerItems(List<String> source) {
    List<Text> result = [];
    for (String str in source) {
      result.add(Text(str));
    }
    return result;
  }

  void selectorChanged(selection) {
    setState(() {
      selectedCrypto = selection;
    });
  }

  Widget iosPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: selectorChanged,
      children: getPickerItems(currenciesList),
      backgroundColor: Colors.lightBlue,
    );
  }

  Widget androidDropDown() {
    return DropdownButton<String>(
      value: selectedCrypto,
      items: getDropDownMenuItems(currenciesList),
      onChanged: selectorChanged,
    );
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? $selectedCrypto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
