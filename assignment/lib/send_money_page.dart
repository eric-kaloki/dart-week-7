import 'package:flutter/material.dart';
import 'custom_button.dart'; // Import the custom button widget

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String _recipientName = '';
  double _amount = 0.0;
  String _paymentMethod = 'Bank Transfer';
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Recipient Name',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a recipient name';
                      }
                      return null;
                    },
                    onSaved: (value) => _recipientName = value!,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || double.tryParse(value) == null || double.parse(value) <= 0) {
                        return 'Please enter a valid amount';
                      }
                      return null;
                    },
                    onSaved: (value) => _amount = double.parse(value!),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: _paymentMethod,
                    items: const [
                      DropdownMenuItem(value: 'M-Pesa', child: Text('M-Pesa')),
                      DropdownMenuItem(value: 'Airtel Money', child: Text('Airtel Money')),
                      DropdownMenuItem(value: 'Bank Transfer', child: Text('Bank Transfer')),
                      DropdownMenuItem(value: 'Credit Card', child: Text('Credit Card')),
                      DropdownMenuItem(value: 'PayPal', child: Text('PayPal')),
                      
                    ],
                    onChanged: (value) => setState(() => _paymentMethod = value!),
                    decoration: const InputDecoration(
                      labelText: 'Payment Method',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mark as Favorite', style: TextStyle(fontSize: 16)),
                    Switch(
                      value: _isFavorite,
                      onChanged: (value) => setState(() => _isFavorite = value),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Send Money',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Show success message with animation
                      showDialog(
                        context: context,
                        builder: (context) => AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(seconds: 1),
                          child: AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Transaction completed successfully!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  setState(() {
                                    _formKey.currentState!.reset(); // Clear the form
                                    _paymentMethod = 'Bank Transfer'; // Reset dropdown to default
                                    _isFavorite = false; // Reset switch to default
                                  });
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
