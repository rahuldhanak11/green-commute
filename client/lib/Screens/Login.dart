import 'package:flutter/material.dart';
import 'package:transport_app/Screens/Otp.dart';
import 'package:transport_app/Screens/Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 75),
                  Text(
                    'Hello there!',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 250, 30, 78),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Sans',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 37, 31, 50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Enter your Email',
                            hintStyle: TextStyle(
                              fontFamily: 'Sans',
                              color: const Color.fromARGB(255, 157, 157, 157),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sans',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Sans',
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 37, 31, 50),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Sans',
                              color: const Color.fromARGB(255, 157, 157, 157),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'We will send you a one-time password (OTP) for verification.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Sans',
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 250, 30, 78),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              "Don't have an account? Sign up here",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Sans',
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
