import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_heroes_library/models/heroshub.dart';
import 'package:flutter_marvel_heroes_library/models/result.dart';
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
  Future<HerosHub> herosHub;
  String url;

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
      var hash =
          generateMd5("$ts" + s.marvelPrivateApiKey + s.marvelPublicApiKey);
      //Prepare ULR
      url =
          "https://gateway.marvel.com:443/v1/public/characters?limit=10&apikey=${s.marvelPublicApiKey}&ts=$ts&hash=$hash";
      //Make api call
      herosHub = _fetchData(url);
      setState(() {});
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

//  Future<HerosHub> _fetchData(String url) async {
//    var res = await http.get(url);
//    print(res.statusCode);
//    print(res.body);
//    var decodedJson = jsonDecode(res.body);
//    return HerosHub.fromJson(decodedJson);
//  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/marvel-logo-second.png',
          height: 30,
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            iconSize: 30,
          )
        ],
      ),
      body: herosHub != null
          ? FutureBuilder<HerosHub>(
              future: herosHub,
              builder: (context, snapshot) {
                print("snapshot is $snapshot");
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.data.results.length,
                        itemBuilder: (context, index) {
                          return _buildCharacter(context, index,
                              snapshot.data.data.results[index]);
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  GestureDetector _buildCharacter(
      BuildContext context, int index, Result superhero) {
    return GestureDetector(
      onTap: () {
        print("open botton sheet");
        _settingModalBottomSheet(context);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 100,
        color: Colors.yellow,
        child: Text('${superhero.name}'),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Music'),
              ),
              new ListTile(
                leading: new Icon(Icons.photo_album),
                title: new Text('Photos'),
              ),
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
              ),
            ],
          );
        });
  }
}


Future<HerosHub> _fetchData(String url) async {
  var response = await http.get(url);
  print(response.statusCode);
  print(response.body);

  // Use the compute function to if parsing takes more than 16ms
  return compute(parseHeros, response.body);
}

// A function that will convert a response body into a HeroHub
HerosHub parseHeros(String responseBody) {
  var decodedJson = jsonDecode(responseBody);
  return HerosHub.fromJson(decodedJson);
}
