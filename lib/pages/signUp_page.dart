import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackBar.dart';
import '../widgets/custom_elevetedButton.dart';
import '../widgets/custom_text_form_filed.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 145,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Create your account.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 67,
              ),
              // CutomFormTextFiled(
              //   hintText: 'Name',
              //   messageValidator: (data) {
              //     if (data!.isEmpty) {
              //       return 'name is required !';
              //     }
              //   },
              // ),
              // const SizedBox(
              //   height: 18,
              // ),
              CutomFormTextFiled(
                hintText: 'Email',
                onChanged: (data) {
                  email = data;
                },
                messageValidator: (data) {
                  if (data!.isEmpty) {
                    return 'email is required !';
                  }
                },
              ),
              const SizedBox(
                height: 18,
              ),
              CutomFormTextFiled(
                isObscure: true,
                hintText: 'Password',
                onChanged: (data) {
                  password = data;
                },
                messageValidator: (data) {
                  if (data!.isEmpty) {
                    return 'password is required !';
                  }
                },
              ),
              const SizedBox(
                height: 36,
              ),
              customElevetedButton(
                textName: 'Sign Up',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await regesterUser();
                      //successfully registered
                      showSnackBar(context,
                          message: 'successfully registered',
                          color: Colors.green);
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context,
                            message: 'The password provided is too weak.',
                            color: Colors.red);
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,
                            message:
                                'The account already exists for that email.',
                            color: Colors.red);
                      }
                    } catch (e) {
                      showSnackBar(context,
                          message: 'There wase an Error!', color: Colors.red);
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
                    'Already have an account,',
                    style: TextStyle(
                      color: Color.fromARGB(255, 134, 131, 131),
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Log In ',
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
      ),
    );
  }

  Future<void> regesterUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
