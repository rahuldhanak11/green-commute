import 'package:flutter/material.dart';
import 'package:transport_app/Screens/Home.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify your number',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 250, 30, 78),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Enter the OTP sent to your phone',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,16,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOtpField(),
                        _buildOtpField(),
                        _buildOtpField(),
                        _buildOtpField(),
                      ],
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 250, 30, 78),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
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

  Widget _buildOtpField() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 37, 31, 50),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Sans',
        ),
        decoration: InputDecoration(
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
