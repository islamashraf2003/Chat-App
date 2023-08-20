import 'package:chat_app/pages/signUp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/show_snackBar.dart';
import '../widgets/custom_elevetedButton.dart';
import '../widgets/custom_text_form_filed.dart';
import 'chat_page.dart';

//Regester Page..
class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 75,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 145,
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            CutomFormTextFiled(
              hintText: 'Email',
              onChanged: (data) {
                email = data;
              },
              messageValidator: (data) {
                if (data!.isEmpty) {
                  return 'Enter your Email.';
                }
              },
            ),
            const SizedBox(
              height: 18,
            ),
            CutomFormTextFiled(
              hintText: 'Password',
              onChanged: (data) {
                password = data;
              },
              isObscure: true,
              messageValidator: (data) {
                if (data!.isEmpty) {
                  return 'Enter your Password';
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            //Log In
            customElevetedButton(
              textName: 'Log In',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await logInUser();
                    //successfully registered
                    showSnackBar(context,
                        message: 'successfully registered',
                        color: Colors.green);
                    Navigator.pushNamed(context, ChatPage.id, arguments: email);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      showSnackBar(context,
                          message: 'user not found.', color: Colors.red);
                    } else if (e.code == 'wrong-password') {
                      showSnackBar(context,
                          message: 'Wrong password.', color: Colors.red);
                    }
                  } catch (e) {
                    showSnackBar(context,
                        message: 'There wase an Error!', color: Colors.red);
                    //print(e);
                  }
                }
                setState(() {
                  isLoading = false;
                });
              },
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don’t have an account,',
                  style: TextStyle(
                    color: Color.fromARGB(255, 134, 131, 131),
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignUp.id);
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return SignUp();
                    //   },
                    // ));
                  },
                  child: const Text(
                    ' Sign Up ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Now',
                  style: TextStyle(
                    color: Color.fromARGB(255, 134, 131, 131),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logInUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
