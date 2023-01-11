import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/authorization_response.dart';
import 'package:oauth2_client/oauth2_client.dart';

const String redirectUri = "sumup_callback_url";

class NetworkHelper {
  static Future<String> getRefreshToken(
      Map<String, dynamic> credentials) async {
    try {
      OAuth2Client client =
          SumupOAuth2Client(redirectUri: redirectUri, customUriScheme: 'poc');
      AuthorizationResponse respAuth = await client.requestAuthorization(
          clientId: credentials["clientId"],
          customParams: {"response_type": "code"}).catchError((onError) {
        print("error $onError");
      });
      String? code = respAuth.code;
      if (code != null) {
        AccessTokenResponse respToken = await client.requestAccessToken(
            code: code, clientId: credentials["clientId"]);
        String? refreshtoken = respToken.refreshToken;
        if (refreshtoken != null) {
          return refreshtoken;
        }
        return "null";
      }
      return "null";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> getAccessTokenWithRefresh(
      Map<String, dynamic> credentials) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://api.sumup.com/token"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'grant_type': 'refresh_token',
          'client_id': credentials["clientId"],
          'client_secret': credentials["clientSecret"],
          'refresh_token': credentials["refreshToken"]
        }),
      );
      print(response.body);
      return jsonDecode(response.body)["access_token"];
    } catch (e) {
      return "problem";
    }
  }
}

class SumupOAuth2Client extends OAuth2Client {
  SumupOAuth2Client(
      {required String redirectUri, required String customUriScheme})
      : super(
            authorizeUrl: 'https://api.sumup.com/authorize',
            tokenUrl: 'https://api.sumup.com/token',
            redirectUri: redirectUri,
            customUriScheme: customUriScheme) {
    this.accessTokenRequestHeaders = {'Accept': 'application/json'};
  }
}
