import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:priject3/screens/signin.dart';

class Forgetpass extends StatelessWidget {
  Forgetpass({super.key});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  void resetPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return; 
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset email sent! Check your inbox.")),
      );

     
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Signin()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send reset email: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey, 
            child: Column(
              children: [
                SizedBox(height: 100),
                Text('Reset Your Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 80),

               
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 250),

                OutlinedButton(
                  onPressed: () => resetPassword(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(36, 133, 230, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 160, vertical: 20),
                  ),
                  child: Text('Send Email', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
