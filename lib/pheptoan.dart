import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máy tính và Kiểm tra số nguyên tố',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorAndPrimeCheckerScreen(),
    );
  }
}

class CalculatorAndPrimeCheckerScreen extends StatefulWidget {
  @override
  _CalculatorAndPrimeCheckerScreenState createState() =>
      _CalculatorAndPrimeCheckerScreenState();
}

class _CalculatorAndPrimeCheckerScreenState
    extends State<CalculatorAndPrimeCheckerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _nController = TextEditingController();

  String _result = '';

  // Hàm tính toán cơ bản
  void _calculate(String operation) {
    if (_formKey.currentState!.validate()) {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);

      setState(() {
        switch (operation) {
          case '+':
            _result = 'Kết quả: $a + $b = ${a + b}';
            break;
          case '-':
            _result = 'Kết quả: $a - $b = ${a - b}';
            break;
          case '*':
            _result = 'Kết quả: $a * $b = ${a * b}';
            break;
          case '/':
            if (b != 0) {
              _result = 'Kết quả: $a / $b = ${a / b}';
            } else {
              _result = 'Lỗi: Không thể chia cho 0';
            }
            break;
        }
      });
    }
  }

  // Hàm kiểm tra số nguyên tố
  bool _isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    for (int i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    return true;
  }

  void _checkPrime() {
    if (_formKey.currentState!.validate()) {
      int n = int.parse(_nController.text);
      bool isPrime = _isPrime(n);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isPrime ? '$n là số nguyên tố' : '$n không phải là số nguyên tố',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _nController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Máy tính & Kiểm tra số nguyên tố'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nhập số a và b
              TextFormField(
                controller: _aController,
                decoration: InputDecoration(labelText: 'Nhập số a'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số a';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Giá trị phải là số';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bController,
                decoration: InputDecoration(labelText: 'Nhập số b'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số b';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Giá trị phải là số';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _calculate('+'),
                    child: Text('+'),
                  ),
                  ElevatedButton(
                    onPressed: () => _calculate('-'),
                    child: Text('-'),
                  ),
                  ElevatedButton(
                    onPressed: () => _calculate('*'),
                    child: Text('*'),
                  ),
                  ElevatedButton(
                    onPressed: () => _calculate('/'),
                    child: Text('/'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              Divider(height: 40),
              // Nhập số n để kiểm tra nguyên tố
              TextFormField(
                controller: _nController,
                decoration: InputDecoration(labelText: 'Nhập số n để kiểm tra nguyên tố'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số n';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Giá trị phải là số nguyên';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkPrime,
                child: Text('Kiểm tra số nguyên tố'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
