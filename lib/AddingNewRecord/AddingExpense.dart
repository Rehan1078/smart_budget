import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:smart_budget/AddingNewRecord/AddingIncome.dart';
import 'package:smart_budget/MainScreen.dart';

import '../DataBaseHandler/DBClass.dart';
import '../ModelClass/ModelClass.dart'; // For database operations

class AddingExpense extends StatefulWidget {
  AddingExpense({super.key});

  @override
  State<AddingExpense> createState() => _AddingExpenseState();
}

class _AddingExpenseState extends State<AddingExpense> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedCategory;
  static const String _type = 'Expense';



  // Function to insert income record
  void _insertExpenseRecord() async {
    if (_selectedCategory == null || _amountController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all required fields.');
      return;
    }

    final record = BudgetRecord(
      category: _selectedCategory!,
      amount: double.parse(_amountController.text),
      date: _dateController.text,
      time: _timeController.text,
      type: _type,
      memo: _memoController.text,
      description: _descriptionController.text,
    );

    final id = await DBHelper().insertData(record);
    if (id != 0) {
      Fluttertoast.showToast(msg: 'Income record added successfully');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Mainscreen()),
            (Route<dynamic> route) => false, // Remove all previous routes
      );
 // Go back after adding
    } else {
      Fluttertoast.showToast(msg: 'Failed to add income record');
    }
  }



  // List of expense categories
  final List<String> _categories = [
    'Bills',
    'Clothing',
    'Education',
    'Entertainment',
    'Fitness',
    'Food',
    'Gifts',
    'Health',
    'Furniture',
    'Pet',
    'Shopping',
    'Transportation',
    'Travel',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    // Automatically set the current date and time when the screen opens
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _dateController.text = formattedDate;

    String formattedTime = DateFormat('HH:mm').format(DateTime.now());
    _timeController.text = formattedTime;
  }

  // Function to open date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  // Function to open time picker
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      String formattedTime = DateFormat('HH:mm').format(selectedTime);
      setState(() {
        _timeController.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          _type,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              child: const Center(child: Text("Save")),
              onTap: _insertExpenseRecord,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.orange,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddingIncome(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.orange,
                      child: const Center(
                        child: Text(
                          "Income",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.redAccent,
                    child: const Center(
                      child: Text(
                        "Expense",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Date picker text field with suffix icon
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date",
                      hintText: "Select Date",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.date_range), // Icon for date picker
                        onPressed: () {
                          _selectDate(context); // Open date picker when the icon is pressed
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () => _selectDate(context), // Open date picker on tap
                  ),
                  const SizedBox(height: 20),
              
                  // Time picker text field with suffix icon
                  TextField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Time",
                      hintText: "Select Time",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time), // Icon for time picker
                        onPressed: () {
                          _selectTime(context); // Open time picker when the icon is pressed
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onTap: () => _selectTime(context), // Open time picker on tap
                  ),
                  const SizedBox(height: 20),
              
                  // Amount text field
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      hintText: "Enter Amount",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.money), // Icon for amount input
                        onPressed: () {},
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
              
                  // Description text field
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter Description",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.description),
                        onPressed: () {},
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
              
                  // Category dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    hint: const Text('Select Category'), // Placeholder text
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
              
                  // Memo text field
                  TextField(
                    controller: _memoController,
                    decoration: InputDecoration(
                      labelText: "Memo",
                      hintText: "Enter Memo",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.comment), // Icon for memo input
                        onPressed: () {},
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
