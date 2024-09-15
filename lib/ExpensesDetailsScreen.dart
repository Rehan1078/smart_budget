import 'package:flutter/material.dart';
import 'package:smart_budget/DataBaseHandler/DBClass.dart';
import '../ModelClass/ModelClass.dart';
import 'MainScreen.dart'; // Import your model class

class Expensesdetails extends StatefulWidget {
  final BudgetRecord record; // Pass the record to the details screen

  const Expensesdetails({super.key, required this.record});

  @override
  State<Expensesdetails> createState() => _ExpensesdetailsState();
}

class _ExpensesdetailsState extends State<Expensesdetails> {
  final DBHelper _dbHelper = DBHelper(); // Instance of DBHelper

  Future<void> _deleteRecord() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Record'),
          content: Text('Are you sure you want to delete this record?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancel
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Confirm
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await _dbHelper.deleteRecord(widget.record.id); // Delete record from DB
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Mainscreen()),
            (Route<dynamic> route) => false, // Remove all previous routes
      ); // Go back to the previous screen
    }
  }

  Future<void> _editRecord() async {
    final updatedRecord = await showDialog<BudgetRecord>(
      context: context,
      builder: (context) {
        // Initialize controllers with existing values from the record
        final TextEditingController categoryController = TextEditingController(text: widget.record.category);
        final TextEditingController amountController = TextEditingController(text: widget.record.amount.toString());
        final TextEditingController memoController = TextEditingController(text: widget.record.memo ?? '');
        final TextEditingController descriptionController = TextEditingController(text: widget.record.description ?? '');

        return AlertDialog(
          title: Text('Edit Record'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category Input
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                SizedBox(height: 10),

                // Amount Input
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                SizedBox(height: 10),

                // Memo Input
                TextField(
                  controller: memoController,
                  decoration: InputDecoration(labelText: 'Memo'),
                ),
                SizedBox(height: 10),

                // Description Input
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // Cancel and close dialog
              },
              child: Text('Cancel'),
            ),

            // Save Button
            TextButton(
              onPressed: () {
                final category = categoryController.text;
                final amount = double.tryParse(amountController.text) ?? widget.record.amount;
                final memo = memoController.text;
                final description = descriptionController.text;

                // Return the updated record when Save is pressed
                Navigator.pop(
                  context,
                  BudgetRecord(
                    id: widget.record.id,
                    category: category,
                    amount: amount,
                    date: widget.record.date, // Keep existing date
                    time: widget.record.time, // Keep existing time
                    type: widget.record.type, // Keep existing type
                    memo: memo, // Updated memo
                    description: description, // Updated description
                  ),
                );
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (updatedRecord != null) {
      await _dbHelper.updateRecord(updatedRecord); // Update record in DB
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Mainscreen()),
            (Route<dynamic> route) => false, // Remove all previous routes
      );// Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Record",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _editRecord,
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: _deleteRecord,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: ${widget.record.category}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Amount: ${widget.record.amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${widget.record.date}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Time: ${widget.record.time}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Type: ${widget.record.type}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Memo: ${widget.record.memo}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Description: ${widget.record.description}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
