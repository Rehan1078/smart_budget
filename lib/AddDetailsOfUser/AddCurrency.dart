import 'package:flutter/material.dart';
import 'package:smart_budget/AddDetailsOfUser/AddInitialammountScreen.dart';

class Addcurrency extends StatefulWidget {
  final String name;
  const Addcurrency({super.key, required this.name});

  @override
  State<Addcurrency> createState() => _AddcurrencyState();
}

class _AddcurrencyState extends State<Addcurrency> {
  String? _selectedCurrency;

  final List<String> currencies = [
    'PKR - Pakistani Rupee',     // Pakistan
    'AED - UAE Dirham',           // Dubai (UAE)
    'INR - Indian Rupee',         // India
    'USD - US Dollar',            // America
    'EUR - Euro',                 // Eurozone
    'GBP - British Pound',        // United Kingdom
    'CNY - Chinese Yuan',         // China
    'JPY - Japanese Yen',         // Japan
    'SAR - Saudi Riyal',          // Saudi Arabia
    'AUD - Australian Dollar'     // Australia
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Currency",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "What is your favourite currency",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),

            // DropdownButton for currency selection
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedCurrency,
              hint: Text('Select a currency'),
              items: currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue;
                });
              },
              underline: Container(
                height: 2,
                color: Colors.orange, // Change this to match your design
              ),
              icon: Icon(Icons.arrow_drop_down),
            ),

            SizedBox(height: 40),
            InkWell(
              onTap: () {
                if (_selectedCurrency != null) {
                  movetonext();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a currency')),
                  );
                }
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void movetonext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddInitialAmount(
          name: widget.name,
          currency: _selectedCurrency!,
        ),
      ),
    );
  }
}
