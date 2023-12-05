import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sello_via/screens/registerScreen.dart';
import 'package:sello_via/widgets/Custombuttons.dart';
import 'package:sello_via/widgets/navbar.dart';
import '../appConts/routes.dart';
import '../widgets/loadin_widget.dart';
import 'Profilepage.dart';
import 'home.dart';

class LogInscreen extends StatefulWidget {
  @override
  State<LogInscreen> createState() => _LogInscreenState();
}

class _LogInscreenState extends State<LogInscreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth=FirebaseAuth.instance;

  bool passwordVisible=true;

  void login(BuildContext context) {
    String email=emailController.text;
    String pwd=passwordController.text;

    if(email.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your vaild email address"))
      );
    }
    else if(pwd.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your vaild password"))
      );
    }
    else{
      showLoading(context);
      _auth.signInWithEmailAndPassword(
        email: email,
        password: pwd
      ).then((UserCredential credential) {

        Navigator.pushNamed(context, Routes.profilepage);
      }).onError((FirebaseAuthException error, stackTrace) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(error.message!))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 50),
        child: ListView(
          children: [
            Topbarlogin(),
            const SizedBox(
              height: 55,
            ),
            const Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ), // Log IN

            const SizedBox(
              height: 30,
            ),
            const Text(
              "Sign up with one of the following options",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginWithSocial("assets/Google.png"),
                LoginWithSocial('assets/x.png'),
                LoginWithSocial('assets/Apple.png'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 1,
                  color: Colors.black26,
                )),
                Text(
                  "Or",
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                Expanded(
                    child: Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 1,
                  color: Colors.black26,
                )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 500,
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE1E1E1),
                //color: Color(0xFFE1E1E1),
              ),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text("Email"),
                  hintText: "Enter your Email",
                  border: InputBorder.none,
                ),
              ),
            ), // Email Input field
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 500,
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE1E1E1),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration:  InputDecoration(
                  label: Text("Password"),
                  hintText: "Enter your Password",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 500,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:
                    const LinearGradient(colors: [Colors.red, Colors.purple]),
              ),
              child: TextButton(
                onPressed: () {
                  login(context);
                },
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not Have An Account? "),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerscreen);

                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
