// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentvehicle_one/Owner/owner_otp.dart';
// import 'package:file_picker/file_picker.dart';

class OwnerRegistrationScreen extends StatefulWidget {
  const OwnerRegistrationScreen({super.key});

  @override
  State<OwnerRegistrationScreen> createState() => _OwnerRegistrationScreenState();
}

class _OwnerRegistrationScreenState extends State<OwnerRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? identityProofURL;
  String? vehicleRCURL;
  double uploadProgress = 0.0; // Track upload progress

  Future<void> _createAccount(BuildContext context) async {
    try {
      final String name = nameController.text.trim();
      final String mobile = mobileController.text.trim();
      final String address = addressController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Check if password and confirm password match
      if (password != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Passwords do not match."),
        ));
        return;
      }

      // Create user with email and password
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user details to Firestore
      await _firestore.collection('owners').doc(userCredential.user!.uid).set({
        'name': name,
        'mobile': mobile,
        'address': address,
        'email': email,
        'identityProofURL': identityProofURL,
        'vehicleRC_URL': vehicleRCURL,
      });
      // Navigate to OTP verification screen
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerificationScreen(
            phoneNumber: mobile,
            userId: userCredential.user!.uid,
          ),
        ),
      );

      // Navigate to another screen or perform any action after successful registration
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Account created successfully."),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error creating account: $error"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOR OWNER"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "New Renter Registration",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please enter the details below",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: "Please enter country code (e.g.+91) "),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // final url = await _uploadDocument(context, "identity_proof");
                // if (url != null) {
                //   setState(() {
                //     identityProofURL = url;
                //   });
                // }
              },
              child: const Text('Submit the Identity Proof'),
            ),
            if (identityProofURL != null)
              LinearProgressIndicator(
                value: uploadProgress,
                minHeight: 10,
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                // final url = await _uploadDocument(context, "vehicel_rc");
                // if (url != null) {
                //   setState(() {
                //     vehicleRCURL = url;
                //   });
                // }
              },
              child: const Text('Submit the Vehicel RC'),
            ),
            if (vehicleRCURL != null)
              LinearProgressIndicator(
                value: uploadProgress,
                minHeight: 10,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _createAccount(context),
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
