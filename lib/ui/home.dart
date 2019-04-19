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
import 'customized/marvelbottomsheet.dart';
import 'customized/rounded_model.dart';

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
          "https://gateway.marvel.com:443/v1/public/characters?limit=5&apikey=${s.marvelPublicApiKey}&ts=$ts&hash=$hash";
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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 16, 10, 10),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:Colors.red,
                    ),
                    child: Text("Popular",style: TextStyle(color: Colors.white,fontSize: 20 ),),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: Text("A-Z",style: TextStyle(color: Colors.black,fontSize: 20 ),),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: Text("Last viewed",style: TextStyle(color: Colors.black,fontSize: 20 ),),
                  )
                ],
              ),
            ),
            Expanded(
              child:             herosHub != null
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
            )

          ],
        ),
      )

    );
  }

  Widget _buildCharacter(BuildContext context, int index, Result superhero) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 70, spreadRadius: -80, offset: Offset(0, 40))
      ]),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(30)),
                  image: DecorationImage(
                      image: NetworkImage(
                    '${superhero.thumbnail.path}.${superhero.thumbnail.extension}'
                  ),fit: BoxFit.cover)),
              width: 130,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text('${superhero.name}',
                          style: Theme.of(context).textTheme.headline),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: superhero.description != ''
                            ? Text(
                                '${superhero.description}',
                                style: Theme.of(context).textTheme.body1,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text('No description'),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      onTap: () {
                        _settingModalBottomSheet(context, superhero);
                      },
                      title: Text(
                        'More info',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      trailing: Icon(Icons.navigate_next),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context, Result superhero) {
    print('${superhero.thumbnail.path}.${superhero.thumbnail.extension}');
    showRoundedModalBottomSheet(
        radius: 25,
        color: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    image: DecorationImage(
                        image: NetworkImage(
                            '${superhero.thumbnail.path}.${superhero.thumbnail.extension}'),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Text(superhero.name,style: Theme.of(context).textTheme.headline,),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: superhero.description != ""
                    ?Text(superhero.description,style: Theme.of(context).textTheme.body1,)
                :Text('No description'),
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

  // Use the compute function to if parsing takes more than 16ms using seperate isolates
  return compute(parseHeros, response.body);
}

// A function that will convert a response body into a HeroHub
HerosHub parseHeros(String responseBody) {
  var decodedJson = jsonDecode(responseBody);
  return HerosHub.fromJson(decodedJson);
}
