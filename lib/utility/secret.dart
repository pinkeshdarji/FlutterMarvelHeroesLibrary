class Secret {
  final String marvelPublicApiKey;
  final String marvelPrivateApiKey;

  Secret({this.marvelPublicApiKey = "", this.marvelPrivateApiKey = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
        marvelPublicApiKey: jsonMap["marvel_public_key"],
        marvelPrivateApiKey: jsonMap["marvel_private_key"]);
  }
}
