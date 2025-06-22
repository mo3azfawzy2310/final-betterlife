import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _loading = false;
  List<Map<String, dynamic>> _paymentMethods = [];
  bool _isLoadingMethods = true;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    setState(() {
      _isLoadingMethods = true;
    });

    try {
      // Simulate loading saved payment methods
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock saved payment methods
      _paymentMethods = [
        {
          'id': 'pm_1',
          'brand': 'visa',
          'last4': '4242',
          'expMonth': 12,
          'expYear': 2025,
          'name': 'John Doe',
          'email': 'john.doe@example.com',
        },
        {
          'id': 'pm_2',
          'brand': 'mastercard',
          'last4': '5555',
          'expMonth': 8,
          'expYear': 2026,
          'name': 'John Doe',
          'email': 'john.doe@example.com',
        },
      ];
    } catch (e) {
      print('Error loading payment methods: $e');
    } finally {
      setState(() {
        _isLoadingMethods = false;
      });
    }
  }

  Future<String> _fetchPaymentIntent() async {
    // This should call your backend to create a payment intent
    // For demo purposes, we'll use a mock response
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, you would make an API call to your backend
    // final response = await http.post(
    //   Uri.parse('https://your-backend.com/create-payment-intent'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'amount': 1000, // Amount in cents
    //     'currency': 'usd',
    //   }),
    // );
    
    // Mock client secret for demo
    return 'pi_3OqX8X2eZvKYlo2C1gQJQJQJ_secret_1234567890';
  }

  Future<void> _addNewPaymentMethod() async {
    try {
      // Create payment method
      final paymentMethod = await stripe.Stripe.instance.createPaymentMethod(
        params: stripe.PaymentMethodParams.card(
          paymentMethodData: stripe.PaymentMethodData(
            billingDetails: stripe.BillingDetails(
              name: 'John Doe',
              email: 'john.doe@example.com',
            ),
          ),
        ),
      );

      // Add to list
      setState(() {
        _paymentMethods.add({
          'id': paymentMethod.id,
          'brand': paymentMethod.card?.brand ?? 'unknown',
          'last4': paymentMethod.card?.last4 ?? '0000',
          'expMonth': paymentMethod.card?.expMonth ?? 12,
          'expYear': paymentMethod.card?.expYear ?? 2025,
          'name': 'John Doe',
          'email': 'john.doe@example.com',
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment method added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding payment method: $e')),
      );
    }
  }

  Future<void> _makePayment(Map<String, dynamic> paymentMethod) async {
    setState(() {
      _loading = true;
    });

    try {
      final clientSecret = await _fetchPaymentIntent();

      await stripe.Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: stripe.PaymentMethodParams.card(
          paymentMethodData: stripe.PaymentMethodData(
            billingDetails: stripe.BillingDetails(
              name: 'John Doe',
              email: 'john.doe@example.com',
            ),
          ),
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment completed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _removePaymentMethod(String paymentMethodId) {
    setState(() {
      _paymentMethods.removeWhere((pm) => pm['id'] == paymentMethodId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment method removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: const Color(0xFF199A8E),
        foregroundColor: Colors.white,
      ),
      body: _isLoadingMethods
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFF199A8E).withOpacity(0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Payment Methods',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Manage your saved payment methods for quick and secure transactions.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Payment methods list
                Expanded(
                  child: _paymentMethods.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _paymentMethods.length,
                          itemBuilder: (context, index) {
                            final paymentMethod = _paymentMethods[index];
                            return _buildPaymentMethodCard(paymentMethod);
                          },
                        ),
                ),
                
                // Add new payment method button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _addNewPaymentMethod,
                      icon: const Icon(Icons.add),
                      label: const Text('Add New Payment Method'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199A8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No payment methods yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a payment method to make quick and secure payments',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> paymentMethod) {
    final brand = paymentMethod['brand'] as String?;
    final last4 = paymentMethod['last4'] as String?;
    final expMonth = paymentMethod['expMonth'] as int?;
    final expYear = paymentMethod['expYear'] as int?;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Card icon
                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _getCardColor(brand),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      _getCardBrandText(brand),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Card details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '•••• •••• •••• ${last4 ?? '0000'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Expires ${(expMonth ?? 12).toString().padLeft(2, '0')}/${expYear ?? 2025}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Actions
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'pay':
                        _makePayment(paymentMethod);
                        break;
                      case 'remove':
                        _removePaymentMethod(paymentMethod['id']);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'pay',
                      child: Row(
                        children: [
                          Icon(Icons.payment, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Make Payment'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Remove'),
                        ],
                      ),
                    ),
                  ],
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
            
            // Payment button
            if (_loading)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Color _getCardColor(String? brand) {
    switch (brand?.toLowerCase()) {
      case 'visa':
        return Colors.blue;
      case 'mastercard':
        return Colors.orange;
      case 'amex':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getCardBrandText(String? brand) {
    switch (brand?.toLowerCase()) {
      case 'visa':
        return 'VISA';
      case 'mastercard':
        return 'MC';
      case 'amex':
        return 'AMEX';
      default:
        return 'CARD';
    }
  }
}
