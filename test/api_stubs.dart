import 'package:my_pokedex/api.dart';

class DelayedApi implements Api {
  final Api _baseApi;
  final int _delay;
  DelayedApi(int delay, Api api): _delay = delay, _baseApi = api;

  Future<String> request(String key) {
    return Future
        .delayed(Duration(seconds: _delay))
        .then((_) => _baseApi.request(key));
  }
}

class SuccessfulApi implements Api {
  final String _response;
  SuccessfulApi(String response): _response = response;

  Future<String> request(String key) {
    return Future.value(_response);
  }
}
