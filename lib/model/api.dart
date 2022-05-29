part of model;

class API {
  //singleton
  static final API _singleton = API._internal();
  factory API() {
    return _singleton;
  }
  API._internal();

  final String _apiKey = 'nsxVLaLBppkqad8o2mJU7KLSLQ3j2ialQ75VaeDz';

  String get apiKey {
    return _apiKey;
  }

  Future<Agency> fetchAgency(String input) async {
    final response = await http.get(Uri.parse(
        'https://api.gsa.gov/technology/digital-registry/v1/agencies?q=$input&API_KEY=$_apiKey'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var agencyMap = jsonDecode(response.body)['results'][0];
      return Agency.fromJson(agencyMap);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load agency');
    }
  }
}
