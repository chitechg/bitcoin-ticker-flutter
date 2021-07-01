import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';

class PriceScreen extends StatefulWidget {

  PriceScreen({this.coinPricesData});

  final coinPricesData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  CoinData coinData = CoinData();
  var theData;

  String selectedCurrency = 'USD';
  String cryptoType;
  String currencyType;
  int rate;

  DropdownButton<String> androidDropdown(){
    List<DropdownMenuItem<String>> dropdownItems = [];
    for(int i = 0; i < currenciesList.length; i++)
    {
      var newItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value){
        setState(() {
        selectedCurrency = value;
      });
      },
    );

  }

  CupertinoPicker iOSPicker()
  {
    List<Text> pickerItems = [];
    for(int i = 0; i < currenciesList.length; i++)
    {
      pickerItems.add(Text(currenciesList[i]));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){

      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();

    updateUI();
  }
  void updateUI() async
  {
    theData = await coinData.getCurrencyData();
    setState(() {

      if(coinData == null)
      {
        print("COIN SCREEN: something fucked up");
        return;
      }
      cryptoType = theData['asset_id_base'];
      print(cryptoType);
      currencyType = theData['asset_id_quote'];
      print(currencyType);
      rate = theData['rate'].toInt();
      print(rate);
    });

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
                  '1 $cryptoType = $rate $currencyType',
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
            child:Platform.isAndroid ? androidDropdown() : iOSPicker(),
          ),
        ],
      ),
    );
  }
}
