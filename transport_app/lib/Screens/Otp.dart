import 'package:flutter/material.dart';
import 'package:transport_app/Navbar.dart';
import 'package:transport_app/Screens/Login.dart';
import 'package:transport_app/api-service.dart';

class OtpScreen extends StatefulWidget {
  final String userId;

  const OtpScreen({required this.userId, Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpControllers = List<TextEditingController>.generate(4, (_) => TextEditingController());
  final _focusNodes = List<FocusNode>.generate(4, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1) {
          if (i < _otpControllers.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    String otp = _otpControllers.map((controller) => controller.text).join();
    print('OTP: $otp');
    print('User ID: ${widget.userId}');

    try {
      final response = await ApiService.verifyOtp(widget.userId, otp);

      if (response['data'] != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verification failed: ${response['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 31, 50),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.7,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 16, 25),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify your Email',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 250, 30, 78),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Enter the OTP sent to your email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => _buildOtpField(index)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                _isLoading ? null : _verifyOtp();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 250, 30, 78),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 31, 50),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Sans',
        ),
        decoration: InputDecoration(
          counterText: '', // Hide the counter text
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 157, 157, 157),
          ),
        ),
      ),
    );
  }
}
