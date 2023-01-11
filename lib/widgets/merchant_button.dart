import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiplesumup/screens/payment_screen.dart';
import 'package:multiplesumup/services/request_token.dart';
import 'package:multiplesumup/utils/merchant.dart';
import 'package:sumup/sumup.dart';

class MerchantButton extends StatelessWidget {
  MerchantButton({required this.merchant});

  final Merchant merchant;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(45, 45)),
        padding: MaterialStateProperty.all(EdgeInsets.all(5)),
      ),
      onPressed: () async {
        try {
          var isLogged = await Sumup.isLoggedIn;
          if (isLogged != null) {
            await Sumup.logout();
          }
          await Sumup.init(merchant.toJson()['affiliateKey']);
        } catch (e) {
          await Sumup.init(merchant.toJson()['affiliateKey']);
        }

        var accesstoken;
        if (merchant.toJson()["refreshToken"] != "unknow") {
          accesstoken = await simpleAccessWithRefresh();
          if (accesstoken == "problem") {
            accesstoken = await fullAccess();
          }
        } else {
          accesstoken = await fullAccess();
        }
        print("Access Token : " + accesstoken);

        await Sumup.login(accesstoken);
        if (accesstoken != "problem") {
          var sumupMerchant = await Sumup.merchant;
          var merchantCode = sumupMerchant.merchantCode;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentScreen(actualMerchant: merchant, merchantCode: merchantCode),
            ),
          );
        }
      },
      child: FittedBox(
          fit: BoxFit.contain,
          child: Text(merchant.toJson()["merchantName"],
              style: TextStyle(fontSize: 45))),
    );
  }

  Future<String> simpleAccessWithRefresh() async {
    return await NetworkHelper.getAccessTokenWithRefresh(merchant.toJson());
  }

  Future<String> fullAccess() async {
    var refreshtoken = await NetworkHelper.getRefreshToken(merchant.toJson());
    merchant.updateRefresh(refreshtoken);
    final _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("merchant")
        .doc(merchant.toJson()["path"])
        .update(merchant.toJson());
    var accesstoken =
        await NetworkHelper.getAccessTokenWithRefresh(merchant.toJson());
    return accesstoken;
  }
}
