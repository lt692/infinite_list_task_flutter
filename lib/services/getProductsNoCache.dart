import 'package:http/http.dart';

Future<Response> fetchDataFromApi() async {
  //? Tarp https://rapidapi.com/ neradau užduoties atitinkančio RESTapi su puslapiavimu ir produktų sąrašu todėl naudosiu github'e esantį json dummy data.
  //* https://raw.githubusercontent.com/GoogleChromeLabs/sample-pie-shop/master/src/data/products.json
  // Photo loading from random
  // https://picsum.photos/536/354
  //
  String authority = "raw.githubusercontent.com";
  String unencodedPath =
      "/GoogleChromeLabs/sample-pie-shop/master/src/data/products.json";
  Uri _apiUrl = Uri.https(authority, unencodedPath);
  return await get(_apiUrl);
}
