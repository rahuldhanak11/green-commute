import 'package:flutter/material.dart';
import 'package:transport_app/Screens/Login.dart';
import 'package:transport_app/api-service.dart';
import 'package:transport_app/Screens/Otp.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  void _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.signUpUser(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (response['data'] != null && response['data']['id'] != null) {
        // print(response['data']); 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(userId: response['data']['id'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed: ${response['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: $e')),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 75),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 250, 30, 78),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Username',
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
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Enter your Username',
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
                      obscureText: true, // Hide password text
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
                  const SizedBox(height: 20),
                  Text(
                    'Get ready to embark on your journey! We’ll need just a few minutes...',
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
                _isLoading ? null : _signUpUser();
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
                      'Sign Up',
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
}
