import 'dart:convert';

import 'package:appstore/pages/auth/register.dart';
import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/pages/shared/widgets/const.dart';
import 'package:appstore/pages/shared/widgets/custombuttonauth.dart';
import 'package:appstore/pages/shared/widgets/customlogoauth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  // TextEditingController username = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisble = true;
  bool isloding = false;
  // ignore: prefer_typing_uninitialized_variables

  Future<void> login() async {
    print("object");
    setState(() {
      isloding = true;
    });
    final url = Uri.parse('https://dummyjson.com/users/add');
    final response = await http.post(url,
        // headers: {'Content-Type': 'application/json'},
        body: json
            .encode({'username': username.text, 'password': password.text}));

    if (response.statusCode == 200 || response.statusCode == 200) {
      ShowsnackBar(context, "You have been logged in successfully");

      print(response.body);
      final data = json.decode(response.body);
      final token = data['token'];
      print('Login successful. Token: $token');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print("no");
      ShowsnackBar(
          context, 'Login failed. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }

    if (mounted) {
      setState(() {
        isloding = false;
      });
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
                "Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                // validator: (email) {
                //   if (email!.contains(RegExp(
                //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                //     return "Enter a valid emial";
                //   }
                // },
                controller: username,
                keyboardType: TextInputType.emailAddress,
                decoration: decoration.copyWith(
                    hintText: "Enter your username :",
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
                  if (password!.length < 8) {
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
                  onPressed: () async {
                    await login();
                    // if (_key.currentState!.validate()) {

                    // }
                  }),

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

  void dispose() {
    username.clear();

    password.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
