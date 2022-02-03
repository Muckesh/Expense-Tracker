import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final String transactionName;
  final String money;
  final String incomeOrexpense;

  Transactions({
   required this.transactionName,
   required this.money,
    required this.incomeOrexpense,

});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: incomeOrexpense == 'income'?Colors.greenAccent:Colors.redAccent,
                    ),
                    child: Center(
                      child: Text("₹",style: TextStyle(fontSize: 35,color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(transactionName,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: Colors.black87
                    ),
                  ),
                ],
              ),
              Text((incomeOrexpense == 'income'?'+ ':'- ')+'₹ '+money,
                style: TextStyle(
                    color: incomeOrexpense == 'income'?Colors.greenAccent:Colors.redAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.w900
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
