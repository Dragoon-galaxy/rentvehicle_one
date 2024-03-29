import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentvehicle_one/Customer/customer_homescreen.dart';
import 'package:rentvehicle_one/pages/login_as_c_o.dart';
import 'package:shared_preferences/shared_preferences.dart';

const startAlignment = Alignment.topCenter;
const endAlignment = Alignment.bottomCenter;

Color color1 = Colors.white;
Color color2 = Colors.lightBlue;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SharedPreferences _prefs;
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _loadFirstTimeStatus();
  }

  Future<void> _loadFirstTimeStatus() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTime = _prefs.getBool('firstTime') ?? true;
      if (_isFirstTime) {
        _prefs.setBool('firstTime', false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime) {
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
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      'Your Ride Awaits!',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage('images/rectangle-4.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 120.0, right: 120.0,),
                child: SizedBox(
                  height: 20.0,
                  child: Divider(
                    color: Colors.blueGrey.shade900,
                    thickness: 2.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 50.0,
                  top: 3.0,
                  right: 50.0,
                  bottom: 50.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginCommonScreenState(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 41, 2, 109),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 6,
                    textStyle: const TextStyle(
                      letterSpacing: 2,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Let\'s Go'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
     } else {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Waiting for Firebase Authentication to check the state
            return const CircularProgressIndicator(); // or a loading screen
          } else {
            if (snapshot.hasData) {
              // User is already logged in, navigate to HomeScreen
              return const CustomerHomeScreen();
            } else {
              // User is not logged in, navigate to EntryScreen
              return const LoginCommonScreenState();
            }
          }
        },
    );
  }
  }
}