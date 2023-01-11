import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiplesumup/services/google_auth_api.dart';
import 'package:multiplesumup/utils/merchant.dart';
import 'package:multiplesumup/widgets/merchant_button.dart';

//import 'package:sumup/sumup.dart';
final _firestore = FirebaseFirestore.instance;
List<Merchant> listMerchant = [];

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GoogleAuthApi.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SUMUP plugin'),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('merchant').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return new GridView.count(
                      padding: EdgeInsets.all(30),
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 3
                          : 5,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      children: snapshot.data!.docs.map((document) {
                        return new MerchantButton(
                            merchant: Merchant.fromData(document.data()));
                      }).toList());
                }
              }) /*

            TextButton(
              onPressed: () async {
                var isInProgress = await Sumup.isCheckoutInProgress;
                print(isInProgress);
              },
              child: Text('Is checkout in progress'),
            ),
            TextButton(
              onPressed: () async {
                var merchant = await Sumup.merchant;
                print(merchant);
              },
              child: Text('Current merchant'),
            ),
            TextButton(
              onPressed: () async {
                var logout = await Sumup.logout();
                print(logout);
              },
              child: Text('Logout'),
            ),*/

          ),
    );
  }
}
