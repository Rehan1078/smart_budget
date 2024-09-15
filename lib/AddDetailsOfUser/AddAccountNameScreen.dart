import 'package:flutter/material.dart';
import 'package:smart_budget/AddDetailsOfUser//AddCurrency.dart';

class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  final _formKey = GlobalKey<FormState>(); // Key for Form widget
  final _nameController = TextEditingController(); // Controller for TextFormField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Form(
          key: _formKey, // Assign the key to the Form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Choose A Name For Your Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name', // Add hint text
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange, // Border color for non-focused state
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange, // Yellow border when enabled
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange, // Yellow border when focused
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name'; // Validation message
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    movetonext(); // Call function only if validation passes
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
      ),
    );
  }

  void movetonext() {
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => Addcurrency(name: _nameController.text,),));
  }
}
