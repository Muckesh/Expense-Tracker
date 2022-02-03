import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/Screens/add_button.dart';
import 'package:my_app/Screens/loading_circle.dart';
import 'package:my_app/Screens/top_card.dart';
import 'package:my_app/Screens/transactions.dart';
import 'package:my_app/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text('N E W  T R A N S A C T I O N'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'For what?',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.grey[600],
                    child:
                    Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[600],
                    child: Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }


  // waiting for data from api
  bool timerHasStarted=false;
  void startLoading(){
    timerHasStarted=true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading==false){
        setState(() {});
        timer.cancel();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && timerHasStarted == false){
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: Text("EXPENSE TRACKER"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TopCard(income: GoogleSheetsApi.calculateIncome().toString(), expense: GoogleSheetsApi.calculateExpense().toString(), balance: (GoogleSheetsApi.calculateIncome() - GoogleSheetsApi.calculateExpense() ).toString()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
                    children: [
                      Expanded(
                          child: GoogleSheetsApi.loading == true
                              ? LoadingCircle()
                              : ListView.builder(
                              itemCount: GoogleSheetsApi.currentTransactions.length,
                              itemBuilder: (context,index){
                            return Transactions(
                                transactionName: GoogleSheetsApi.currentTransactions[index][0],
                                money: GoogleSheetsApi.currentTransactions[index][1],
                                incomeOrexpense: GoogleSheetsApi.currentTransactions[index][2],
                            );
                          }),
                      ),

                    ],
                  )
              )
            ),
          ),
          AddButton(
            function: _newTransaction,
          ),
        ],
      ),
    );
  }
}

