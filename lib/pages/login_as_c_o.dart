import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentvehicle_one/Customer/customer_login.dart';
// import 'package:rentvehicle_one/Owner/owner_login.dart';
import 'package:rentvehicle_one/Customer/customer_signup.dart';

const startAlignment = Alignment.topCenter;
const endAlignment = Alignment.bottomCenter;

Color color1 = Colors.white;
Color color2 = Colors.lightBlue;

class LoginCommonScreenState extends StatelessWidget {
  const LoginCommonScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: startAlignment,
            end: endAlignment,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 55.0),
                    const Image(
                      image: AssetImage('images/rectangle-7.png'),
                      width: 250,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'SWIFTSHARE',
                      style: GoogleFonts.kalam(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 234, 13, 98),
                        letterSpacing: 2,
                      ),
                    ),
                    const Text(
                      'Wheels on demand',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 260.0),
                    const Text(
                      'Please Sign in or Register',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerLoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 41, 2, 109),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fixedSize: const Size(
                            300, 50), // Adjust the width of the button
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerRegistrationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 41, 2, 109),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fixedSize: const Size(
                            300, 50), // Adjust the width of the button
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
