import 'package:appstore/pages/auth/login.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/pages/shared/widgets/const.dart';
import 'package:appstore/pages/shared/widgets/custombuttonauth.dart';
import 'package:appstore/pages/shared/widgets/customlogoauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Registre extends StatefulWidget {
  const Registre({super.key});

  @override
  State<Registre> createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {
  final _keyForm = GlobalKey<FormState>();
  // TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisble = true;
  bool isloding = false;
  regisrerUser() async {
    try {
      setState(() {
        isloding = true;
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      context.read<Model>().islogin(true);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowsnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ShowsnackBar(context, 'The account already exists for that email.');
      }
    } catch (e) {
      ShowsnackBar(context, "Error");
    }

    setState(() {
      isloding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      key: _keyForm,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              CustomLogoAuth(
                logo: "assets/logo/registre.png",
              ),
              Container(height: 20),
              const Text("Registre",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Registre To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              // Container(height: 20),
              // const Text(
              //   "username",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // Container(height: 10),
              // CustomTextForm(
              //     hinttext: "ُEnter Your username", mycontroller: username),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  return email!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Enter a valid emial";
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
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          isloding
              ? Center(child: CircularProgressIndicator())
              : CustomButtonAuth(
                  title: "Registre",
                  onPressed: () async {
                    // if (_keyForm.currentState!.validate()) {
                      await regisrerUser();
                    // }
                  }),
          Container(height: 20),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
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
