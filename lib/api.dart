import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "expense-tracker-339613",
  "private_key_id": "297337165bf81dbe333670394063920c35c25c02",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCD7lyZ7jxF9bBQ\nShoRqOxrXDKohjC7dxX1cEUUNFwcei7hN/tj2/NwMBAJX8hYiXt8fwmVV4bcQ/g8\n2I/2RLQGDMAelga6qEBZGNpsa+67b6d8rDTUqHTHERM8FJq8HOU0T/We6hRXHiWK\nrykMUby4ffOLlehpu/nbjzjz/5ObkYoz/k1i3lMrLkZujzr50rUJbfETkUl24GZo\ns9lf/0ZIRhcW7Y3Yb0VX95Bo8rVyiSwj+JdpWyUifLC7HYLEgp6+UqDBEZ2f7LOw\n9ZnJbwADsrD33kuYLh6B1icP5EqXqaFMGFdRDpFEUQgIjQW7i/g66Ty5YVk2VMtm\nx0FYNPmfAgMBAAECggEACuwFQ4MK/1mvHn57+QFMjTjFQtlVGHfr2/VO6rTI+VyO\nG/wH9kTjuuJnuXbx/Y5oKC7WKsRjuEFyQAtHo8IdSzDsCLwv020RYq7hij9HNMIy\nEeqptv85J6+8sWkdRDx6JyIFegHz7CBlSD1m/wuXPYjDzEb9Rh+XODt7oguC+0pr\nQlIae9GaLKngtXpTQB6RPs0+RoI1pRbSlucIq4mHh1Wo+UvZMrGuXhmou+sdrW3M\n5SyUdIEWT4kzJqadOByc6uWXTkFYzaSeBCFQfM471oKyeCg9d4Iq8yTTPhG7WSos\nxgl7+V1jq9zbAY4W231SL2aFC3Is1mteo9N4gQZXXQKBgQC33YBha2eEa1h4K2Nk\nytHxWGLosO6to3BAeKIX7cARHYPPUSdZkx2l/W9ZuDCHaMRXjEPFF+9rRNZbaD0U\nETjSERuBQRb7TVvFeoFuaBrFqwqkJ4DWRgmSaaSfqUJYd4HGIvMF0QR4vB6Ru1oa\n2sTesndRM6xCgHO0Hs3feAqMQwKBgQC3sNtbQVPYGls55bJrgHnMnZqEeAi7hRbv\n8q6qIjxrsfslluGSTsLu8NZb8GTeJwxGtbF9K2NV/ms/1pR4q1Ju03VBbtH7VjP+\nMlVIFhs43z+zyJHZ1f5mhVeQp3EdF5Emw5elZsdN6NRz+FtDswYbRLOsoHlpERPJ\nuVp/CTM1dQKBgQCtJe3hUDjy7fgpaoq2f33H7zlt8jlC0dhDDpdvO1kVhRr84GrT\nIwTXrVvwPNGOoy3LWG71q72u4euPtxFV1YYR5URmq3pN/CLBTMWYyHb10UY7Imxk\n3R3kgJIkPUwabaiLg5wizRyN6nJLQQjwozaklaJhmOzOz5KmfB/aI3yjawKBgF4u\nfanCSvzoNpHu5ZYc31Y8EHePG9sZl/MbGNb+isAlF0HkpG9hlqzwKtgk33LPzomK\nqyAkWOBEfDTVDnb4UGGmZd5QtbUKM8pHgFZfj0GPpZfGZJGuGKvz/juavnJOHQwl\nCOGzWsjlcdisJA8IAT+F8CG4fceTC/RH5tBvpSPpAoGBAIZ9KiCRsrlEMOf71LgK\nbH5nBM7wDTZe/u9lkujIoRFB5x5PsoiL15zOhpfRr/pTQiys1vDblKjlqYoAVEML\nhiymsPZDdXdrtBSwZOICahTELgmGwkc3ABKMnhCvTTvg2D98KdqSdNnFH7N/xz5Z\nTxubjRYIvLTr6ltHq8jH70dO\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-expense-tracker@expense-tracker-339613.iam.gserviceaccount.com",
  "client_id": "118341213798735347011",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-expense-tracker%40expense-tracker-339613.iam.gserviceaccount.com"
}
  ''';

  // set up and connect to spreadsheet
  static final _spreadsheetId = "1YA2L43Zfd_knpo6HNrk7ZTJAPz9RClwx1STUrsdH6jA";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // variables to keep track
  static int numberOfTransactions =0;
  static List<List<dynamic>> currentTransactions =[];
  static bool loading = true;

  // initialise the spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }
  // count number of rows
  static Future countRows() async{
    while ((await _worksheet!.values.value(column: 1, row : numberOfTransactions+1))!=''){
      numberOfTransactions++;
    }
    // now we know how many transactions to load, now let's load them!
    loadTransactions();
  }
  // load existing transactions from spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i=1; i< numberOfTransactions; i++){
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i+1);
      final String transactionAmount =
      await _worksheet!.values.value(column: 2, row: i+1);
      final String transactionType =
      await _worksheet!.values.value(column: 3, row: i+1);

      if (currentTransactions.length < numberOfTransactions){
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    //print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // calculate total income
  static int calculateIncome() {
    int totalIncome = 0;
    for (int i = 0;i < currentTransactions.length;i++){
      if (currentTransactions[i][2] == 'income') {
        totalIncome += int.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // calculate total expense
  static int calculateExpense() {
    int totalExpense = 0;
    for (int i = 0;i < currentTransactions.length;i++){
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += int.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}