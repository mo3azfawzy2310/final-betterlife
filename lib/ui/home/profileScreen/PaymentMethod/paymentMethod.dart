import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _loading = false;

  Future<String> fetchClientSecret() async {
    // استبدل الرابط ده بالرابط الخاص بالباك اند بتاع صحابك
    final url = Uri.parse('https://your-backend.com/create-payment-intent');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'amount': 1000, // المبلغ بالمراكز، هنا 10.00 دولار مثلاً
        'currency': 'usd',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['client_secret'];
    } else {
      throw Exception('Failed to fetch payment intent client secret');
    }
  }

  Future<void> startPayment() async {
    setState(() {
      _loading = true;
    });

    try {
      final clientSecret = await fetchClientSecret();

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'BetterLife',
          // Optional: customerId, customerEphemeralKeySecret etc.
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment completed successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة البطاقة الخاصة بك
            GestureDetector(
              onTap: () {
                // هنا ممكن تعمل كمان استجابة عند الضغط على الأيقونة
              },
              child: const Icon(
                Icons.credit_card, // استبدل بالايكون الخاص بيك لو عندك
                size: 100,
                color: Color(0xFF199A8E),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _loading ? null : startPayment,
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Pay with Card'),
            ),
          ],
        ),
      ),
    );
  }
}
