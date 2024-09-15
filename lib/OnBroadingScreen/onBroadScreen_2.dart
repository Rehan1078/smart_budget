import 'package:flutter/material.dart';
import 'package:smart_budget/OnBroadingScreen/onBroadScreen_3.dart';

class onBroad2 extends StatefulWidget {
  const onBroad2({super.key});

  @override
  State<onBroad2> createState() => _onBroad2State();
}

class _onBroad2State extends State<onBroad2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15 ,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21)
                  ),
                  child: Image.asset("assets/img2.jpeg")
              ),
              SizedBox(height: 40,),
              Center(
                child: Text("Invest Your Money Wisely \n With Our Expertise",style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Invest Your Money using our smart invest \n plans and investment assistant",style: TextStyle(
                    fontSize: 18,
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

  void movetonext(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => onBroad3(),));
  }
}
