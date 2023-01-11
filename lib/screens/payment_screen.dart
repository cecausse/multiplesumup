import 'package:flutter/material.dart';
import 'package:multiplesumup/utils/merchant.dart';
import 'package:sumup/sumup.dart';

final title = "Payment page";

class PaymentScreen extends StatefulWidget {
  final Merchant actualMerchant;
  final String? merchantCode;
  const PaymentScreen(
      {Key? key, required this.actualMerchant, required this.merchantCode})
      : super(key: key);
  static const String id = 'payment';
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final myControllerAmount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title + " for " + widget.actualMerchant.merchantName),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                widget.merchantCode == widget.actualMerchant.merchantId
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 80,
                      )
                    : IconButton(
                        iconSize: 80,
                        icon: const Icon(
                          Icons.do_disturb_on,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          final snackBar = SnackBar(
                              content:
                                  Text('Restart the app or contact the dev'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                Text(
                  widget.actualMerchant.merchantName,
                  style: TextStyle(fontSize: 30),
                ),
                TextFormField(
                  controller: myControllerAmount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    prefixIcon: Icon(Icons.euro),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Set the price here';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(400, 70)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    var price = myControllerAmount.text.replaceAll(',', '.');
                    if (widget.merchantCode ==
                        widget.actualMerchant.merchantId) {
                      if (_formKey.currentState!.validate()) {
                        double amount = double.parse(price);
                        print(amount);
                        var payment = SumupPayment(
                          title: 'Payment',
                          total: amount,
                          currency: 'EUR',
                          foreignTransactionId: '',
                          saleItemsCount: 0,
                          skipSuccessScreen: false,
                          tip: .0,
                        );

                        var request = SumupPaymentRequest(payment, info: {
                          'AccountId': 'AccountId',
                          'From': 'From',
                          'To': 'To',
                        });

                        await Sumup.checkout(request);

                        await Sumup.logout();
                        Navigator.pop(context);
                      }
                    } else {
                      final snackBar = SnackBar(
                          content: Text('Restart the app or contact the dev'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    'Validate payment',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
