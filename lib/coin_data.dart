import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<dynamic> getCurrencyData() async
  {
    NetworkHelper networkHelper = NetworkHelper('https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=FC86B31F-7FAD-4AE5-94F6-BD66EF4744E1');
    var theData = await networkHelper.getData();

    return theData;
  }


}
