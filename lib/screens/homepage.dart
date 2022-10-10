import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountcontroller = TextEditingController();
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess() {
    print("Success");
  }

  void _handlePaymentError() {
    print('Error');
  }

  void _handleExternalWallet() {
    print("Wallet open");
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_Ynx5KCVle3fU5Z",
      "amount": num.parse(amountcontroller.text) * 100,
      "name": "Debt",
      "description": "Paying to Shreyash",
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    //opening payment gateway
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Razor Pay Testing')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: amountcontroller,
              decoration: InputDecoration(hintText: "Amount to Pay"),
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: (() => openCheckout()), child: Text("Pay Now!"))
        ]),
      ),
    );
  }
}
