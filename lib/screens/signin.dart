import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:priject3/screens/company_list.dart';
import 'package:priject3/screens/welcome.dart';
import 'forgetpass.dart';

class Signin extends StatelessWidget {
  Signin({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return; 
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: ${e.message}')),
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
                Text('Sign into your account'),
                SizedBox(height: 80),

                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _emailController,
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
                SizedBox(height: 35),

             
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 280),

            
                OutlinedButton(
                  onPressed: () => signInWithEmailAndPassword(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(36, 133, 230, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 160, vertical: 20),
                  ),
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 50),

              
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Forgetpass()));
                  },
                  child: Text('Forgot your password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
