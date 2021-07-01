import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    var urlParse = Uri.parse(url);
    http.Response response = await http.get(urlParse);
    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      return jsonDecode(data);
    }
    else if (response.statusCode == 401) {
      print("api key didn't work");
    }
    else {
      print(response.statusCode);
    }
  }

}

/*
    HTTP status code cheat sheet, from the servers perspective
    1**: hold on
    2**: here you go
    3**: go away
    4**: you fucked up
    5**: i fucked up
     */
