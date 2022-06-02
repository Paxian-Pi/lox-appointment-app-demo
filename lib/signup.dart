import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lox_mobile/login.dart';
import 'package:page_transition/page_transition.dart';

import 'constants.dart';
import 'home_view.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final formKey = GlobalKey<FormState>();

  void _toggleVisibility() {
    setState(() {
      Constants.hideOrShowPassword = !Constants.hideOrShowPassword;
    });
  }

  bool _validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/signup.png"),
            fit: BoxFit.cover,
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     // Colors.purple,
          //     Constant.mainColor,
          //     Constant.accent,
          //   ],
          // ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: const EdgeInsets.only(top: 75), child: Image.asset('assets/logo.png')),
                Column(
                  children: [
                    _welcomeText(),
                    _subWelcomeText(),
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // decoration: const BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(30),
                //     topRight: Radius.circular(30),
                //   ),
                // ),
                margin: const EdgeInsets.only(top: 50),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 200),
                        _emailField(),
                        _passwordField(),
                        // _forgotPassword(),
                        const SizedBox(height: 40),
                        _signupButton(),
                        const SizedBox(height: 20),
                        const Text('OR continue with', style: TextStyle(fontSize: 16.0)),
                        const SizedBox(height: 20),
                        _socialMedia(),
                        const SizedBox(height: 5),
                        _loginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _welcomeText() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.only(left: 25.0),
      child: const Text(
        'The Test',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
  Widget _subWelcomeText() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 25.0),
      child: const Text(
        'Powered by Lox',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black,
      //     width: 1,
      //   ),
      //   // boxShadow: const [
      //   //   BoxShadow(
      //   //     color: Constant.accent,
      //   //     blurRadius: 10,
      //   //     offset: Offset(1, 1),
      //   //   ),
      //   // ],
      //   color: Colors.white,
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(20),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Icon(Icons.email_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  // border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Oops! No email... Make sure to enter a real email";
                  }
                  return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)
                      ? null
                      : "This is not an email";
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 15
      ),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black,
      //     width: 1,
      //   ),
      //   // boxShadow: const [
      //   //   BoxShadow(
      //   //     color: Constant.accent,
      //   //     blurRadius: 10,
      //   //     offset: Offset(1, 1),
      //   //   ),
      //   // ],
      //   color: Colors.white,
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(20),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: Constants.hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      Constants.hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Colors.grey,
                    ),
                  ),
                  label: const Text('Password'),
                  // border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signupButton() {
    return Container(
      margin: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            PageTransition(
              child: const Login(),
              type: PageTransitionType.fade,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          shadowColor: Colors.grey,
          elevation: 3,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.black, Colors.black],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialMedia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/google.png', width: 200.0, height: 55.0),
        // const SizedBox(width: 10.0),
        // const Text('Google', style: TextStyle(fontSize: 20.0)),
        // const SizedBox(width: 50.0),
        Image.asset('assets/facebook.png', width: 200.0, height: 55.0),
        // const Text('Facebook', style: TextStyle(fontSize: 20.0)),
      ],
    );
  }

  Widget _forgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 45.0),
          child: const Text(
            'Already have account ',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Methods.showToast('Sign up clicked!', ToastGravity.BOTTOM);
        //   },
        //   child: Container(),
        // ),
        Container(
          padding: const EdgeInsets.only(left: 45.0),
          // child: const Text(
          //   'Sign Up',
          //   style: TextStyle(
          //     color: Constant.accent,
          //     fontSize: 16.0,
          //     // decoration: TextDecoration.underline,
          //   ),
          // ),
          child: TextButton(
            onPressed: () {
              HapticFeedback.vibrate();
              SystemSound.play(SystemSoundType.click);
              Navigator.of(context).push(
                PageTransition(
                  child: const Login(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
