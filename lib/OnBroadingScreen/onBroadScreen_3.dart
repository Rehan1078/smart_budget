import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_budget/AddDetailsOfUser//AddAccountNameScreen.dart';

class onBroad3 extends StatefulWidget {
  const onBroad3({super.key});

  @override
  State<onBroad3> createState() => _onBroad3State();
}

class _onBroad3State extends State<onBroad3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 15 ,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21)
                  ),
                  child: Image.asset(
                    "assets/img3.jpeg",
                  )
              ),
              SizedBox(height: 40,),
              Center(
                child: Text("Save Your Money and earn \n Exciting Rewards",style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Save Money by setting goals and \n spending limits and earn reward coins",style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                ),
                textAlign: TextAlign.center,),
              ),
              SizedBox(height: 40,),
              InkWell(
                onTap: movetonext,
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orange
                  ),
                  child: Center(
                    child: Text("Continue",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),
                  ),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }

  void movetonext() async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isOnboardingComplete', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddName()),
      );
  }
}
