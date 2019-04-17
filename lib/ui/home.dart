import 'package:flutter/material.dart';
import 'package:flutter_marvel_heroes_library/models/heroshub.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_marvel_heroes_library/utility/secret.dart';
import 'package:flutter_marvel_heroes_library/utility/secretloader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  HerosHub herosHub;

  @override
  void initState() {
    super.initState();

    SecretLoader(secretPath: 'assets/json/secrets.json')
        .load()
        .then((Secret s) {
      print("${s.marvelPrivateApiKey} and ${s.marvelPublicApiKey}");
      //Get current time stamp
      var ts = DateTime.now();
      //Generate MD5 digest to pass in api
      var hash = generateMd5("$ts" + s.marvelPrivateApiKey + s.marvelPublicApiKey);
      //Prepare ULR
      String url =
          "https://gateway.marvel.com:443/v1/public/characters?limit=2&apikey=${s.marvelPublicApiKey}&ts=$ts&hash=$hash";
      //Make api call
      _fetchData(url);
    });


  }

  ///Generate MD5 hash
  generateMd5(String data) {
    print(data);
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void _fetchData(String url) async {
    var res = await http.get(url);
    print(res.statusCode);
    var decodedJson = jsonDecode(res.body);
    herosHub = HerosHub.fromJson(decodedJson);
    print(jsonEncode(herosHub));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MARVEL"),
      ),
    );
  }
}
