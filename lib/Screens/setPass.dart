import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locapass/data/cubitAuth/auth_cubit.dart';
import 'package:locapass/Screens/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setpass extends StatefulWidget {
  const Setpass({super.key});

  @override
  State<Setpass> createState() => SetpassState();
}

class SetpassState extends State<Setpass> {
  String _inputPin = "";
  final int _pinLength = 6;
  bool _isConfirmStage = false;
  String _firstEnteredPin = "";
  String? password;
  final List<Map<String, dynamic>> numbers = [
    {"value": "1", "isNumber": true},
    {"value": "2", "isNumber": true},
    {"value": "3", "isNumber": true},
    {"value": "4", "isNumber": true},
    {"value": "5", "isNumber": true},
    {"value": "6", "isNumber": true},
    {"value": "7", "isNumber": true},
    {"value": "8", "isNumber": true},
    {"value": "9", "isNumber": true},
    {"value": "Back", "isNumber": false},
    {"value": "0", "isNumber": true},
    {"value": "Delete", "isNumber": false},
  ];
  void isPasswordTrue() async {
    final prefs = await SharedPreferences.getInstance();
    final String? LastPassword = prefs.getString("MasterPassword");
    if (_inputPin == LastPassword) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Homepage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is Wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String?> _getMasterPassword() async {
    final prefs = await SharedPreferences.getInstance();
    password = prefs.getString("MasterPassword");
    setState(() {});
  }

  void _onKeypadPressed(Map<String, dynamic> item) {
    setState(() {
      if (item["isNumber"] == true) {
        if (_inputPin.length < _pinLength) {
          _inputPin += item["value"];
        }
      } else if (item["value"] == "Delete") {
        if (_inputPin.isNotEmpty) {
          _inputPin = _inputPin.substring(0, _inputPin.length - 1);
        }
      } else if (item["value"] == "Back") {
        Navigator.of(context).pop();
      }
    });
    if (password != null) {
      if (_inputPin.length == _pinLength) {
        if (_inputPin == password) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Wrong Passowrd"),
              backgroundColor: Colors.red,
            ),
          );
          _inputPin = "";
        }
      }
    } else if (_inputPin.length == _pinLength) {
      if (_isConfirmStage == false) {
        print("PIN Completed: $_inputPin");
        setState(() {
          _firstEnteredPin = _inputPin;
          _inputPin = "";
          _isConfirmStage = true;
        });
      } else {
        if (_inputPin == _firstEnteredPin) {
          context.read<AuthCubit>().saveMasterPassword(_inputPin);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Passwords Saved"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Homepage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Passwords do not match. Try again!"),
              backgroundColor: Colors.redAccent,
            ),
          );
          setState(() {
            _inputPin = "";
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getMasterPassword();
  }

  viewScreen() {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  password != null
                      ? "enter Your\nMaster Password"
                      : _isConfirmStage == false
                      ? "Set Your\nMaster Password"
                      : "Confirm Your\nMaster Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                bool isFilled = index < _inputPin.length;
                double dotSize = screenWidth * 0.035;
                if (dotSize > 14) dotSize = 14;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  width: isFilled ? dotSize + 4 : dotSize,
                  height: isFilled ? dotSize + 4 : dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled
                        ? const Color(0xFF90F1CC)
                        : const Color(0xFF1E293B),
                    boxShadow: isFilled
                        ? [
                            BoxShadow(
                              color: const Color(0xFF90F1CC).withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                );
              }),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numbers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = numbers[index];
                  if (item["isNumber"] == false) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => _onKeypadPressed(item),
                      child: Center(
                        child: Text(
                          "${item["value"]}",
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => _onKeypadPressed(item),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF111827).withOpacity(0.5),
                        border: Border.all(
                          color: const Color.fromARGB(255, 81, 86, 93),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${item["value"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            SizedBox(height: screenHeight * 0.03),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060D1A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.0, -0.9),
            radius: 1.8,
            colors: [
              Color.fromARGB(255, 58, 3, 40),
              Color.fromARGB(0, 0, 0, 0),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(child: viewScreen()),
      ),
    );
  }
}
