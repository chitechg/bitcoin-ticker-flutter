import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

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
  String rateBTC;
  String rateETH;
  String rateLTC;

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
        updateUI();
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
        selectedCurrency = currenciesList[selectedIndex];
        updateUI();
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
    //set these as temp while waiting for actual values
    rateBTC = '?';
    rateETH = '?';
    rateLTC = '?';

    theData = await coinData.getCurrencyData(crypto: 'BTC', currency: selectedCurrency,);
    rateBTC = theData['rate'].toInt().toString(); //drop decimal and make string for easier manipulation
    theData = await coinData.getCurrencyData(crypto: 'ETH', currency: selectedCurrency,);
    rateETH = theData['rate'].toInt().toString();
    theData = await coinData.getCurrencyData(crypto: 'LTC', currency: selectedCurrency,);
    rateLTC = theData['rate'].toInt().toString();

    setState(() {

      if(coinData == null)
      {
        print("COIN SCREEN: something fucked up");
        return;
      }
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
          CryptoCard(rateBTC: rateBTC, selectedCurrency: selectedCurrency),
          CryptoCard(rateBTC: rateETH, selectedCurrency: selectedCurrency),
          CryptoCard(rateBTC: rateLTC, selectedCurrency: selectedCurrency),
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

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.rateBTC,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String rateBTC;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 BTC = $rateBTC $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
