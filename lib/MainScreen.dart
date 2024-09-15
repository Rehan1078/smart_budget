import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_budget/ExpensesDetailsScreen.dart';
import 'AddingNewRecord/AddingIncome.dart';
import 'DataBaseHandler/DBClass.dart';
import '../ModelClass/ModelClass.dart'; // Import your model class

class Mainscreen extends StatefulWidget {
  Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  late Future<List<BudgetRecord>> _recordsFuture = Future.value([]);
  final DBHelper _dbHelper = DBHelper();
  late Future<String> _nameFuture;

  Future<void> _fetchRecords() async {
    try {
      setState(() {
        _recordsFuture = _dbHelper.fetchData(); // Fetch data from the database
      });
    } catch (e) {
      print("Error fetching records: $e");
      // Handle errors or show a message to the user
    }
  }


  @override
  void initState() {
    super.initState();
    _nameFuture = _fetchNameFromSharedPreferences();
    _fetchRecords(); // Fetch records when the screen initializes
  }

  Future<String> _fetchNameFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? 'Default Name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _nameFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            } else if (!snapshot.hasData) {
              return Text(
                'No Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            } else {
              return Text(
                snapshot.data!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            }
          },
        ),
        centerTitle: false,
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddingIncome()),
          );
          _fetchRecords(); // Refresh data after returning from AddingIncome
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Current Balance Text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<double>(
              future: _dbHelper.getBalance(), // Get current balance
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('Balance not available'));
                } else {
                  final balance = snapshot.data!;
                  return Text(
                    'Current Balance: ${balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
          ),
          // Expanded ListView
          Expanded(
            child: FutureBuilder<List<BudgetRecord>>(
              future: _recordsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No records available'));
                } else {
                  final records = snapshot.data!;
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Expensesdetails(record: record),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon on the left
                                Icon(
                                  Icons.description,
                                  color: Colors.orange,
                                  size:58,
                                ),

                                // Category and Amount
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      record.category,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Amount: ${record.amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),

                                // Arrow icon on the right
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: records.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
