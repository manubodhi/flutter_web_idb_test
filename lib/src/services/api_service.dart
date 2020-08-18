import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiData<T> {

  final String url;

  T Function(Response response) parse;
  ApiData({this.url, this.parse});

}

class Webservice {
  Future<T> load<T>(ApiData<T> apiData) async{
    final response = await http.get(apiData.url);
    if(response.statusCode == 200){
      return apiData.parse(response);
    }else{
      throw Exception('Failed to load data');
    }
  }
}

