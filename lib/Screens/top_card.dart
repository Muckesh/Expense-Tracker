import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  final String income;
  final String expense;
  final String balance;

  TopCard({
    required this.income,
    required this.expense,
    required this.balance,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //padding: EdgeInsets.only(top: 8.0),
        height: 200,
        //color: Colors.deepPurpleAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('BALANCE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 10.0,
              ),
              ),
              Text('₹ '+balance,
                style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            child: Icon(Icons.arrow_upward,color: Colors.greenAccent,size: 40,),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Income',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w700),),
                              Text('₹ '+income,style: TextStyle(color: Colors.greenAccent,fontSize: 20.0,fontWeight: FontWeight.w700),),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            child: Icon(Icons.arrow_downward,color: Colors.redAccent,size: 40,),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Expense',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w700),),
                              Text('₹ '+expense,style: TextStyle(color: Colors.redAccent,fontSize: 20.0,fontWeight: FontWeight.w700),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(16)
        ),
      ),
    );
  }
}
