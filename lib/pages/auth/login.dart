import 'package:appstore/pages/auth/register.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/pages/shared/widgets/const.dart';
import 'package:appstore/pages/shared/widgets/custombuttonauth.dart';
import 'package:appstore/pages/shared/widgets/customlogoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  // TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisble = true;
  bool isloding = false;
   // ignore: prefer_typing_uninitialized_variables
  


  loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      ShowsnackBar(context, 'Done....');
      
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowsnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ShowsnackBar(context, 'Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              CustomLogoAuth(
                logo: "assets/logo/login.png",
              ),
              Container(height: 20),
              const Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              // const Text(
              //   "username",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // Container(height: 10),
              // TextFormField(
              //   keyboardType: TextInputType.text,
              //   decoration: decoration.copyWith(hintText: " Enter user name :"),
              // ),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                    validator: (email) {
                      if (email!.contains(RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                 return "Enter a valid emial";
                      }
                    },
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: decoration.copyWith(
                    hintText: "Enter your email :",
                    suffixIcon: Icon(Icons.email)),
              ),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) {
                  
                  if ( password!.length < 8) {
                    return "Enter a valid password";
                  }
                },
                controller: password,
                obscureText: isVisble,
                decoration: decoration.copyWith(
                    hintText: "Enter your password :",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisble = !isVisble;
                          });
                        },
                        icon: isVisble
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          isloding
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButtonAuth(
                  title: "login",
                  onPressed: () {
                    loginUser();
                    // if (_key.currentState!.validate()) {
                    //    loginUser();
                    // }
                  }),
          Container(height: 20),

          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Registre()));
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
