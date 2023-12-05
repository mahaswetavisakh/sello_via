
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sello_via/screens/Login.dart';
import 'package:sello_via/screens/MainScreen.dart';
import 'package:sello_via/screens/Profilepage.dart';
import 'package:sello_via/widgets/Custombuttons.dart';
import 'package:sello_via/widgets/navbar.dart';
import '../appConts/routes.dart';
import '../widgets/loadin_widget.dart';



class RegisterScreen extends StatefulWidget{
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  bool passwordVisible=true;

  final FirebaseAuth _auth=FirebaseAuth.instance;

 void  createAccount(BuildContext context){
   String name=nameController.text;
   String emailId=emailController.text;
   String pwd=passwordController.text;

   if(name.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter your full name"))
    );
   }
   else if(emailId.isEmpty){
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("Please enter your vaild email address"))
     );
   }
   else if(pwd.isEmpty){
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("Please enter your vaild password"))
     );
   } else{
     showLoading(context);
     _auth.createUserWithEmailAndPassword(
        email:emailId,
       password: pwd
     ).then((UserCredential userCredential) async {
        await userCredential.user!.updateDisplayName(name);
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
        padding: const EdgeInsets.only(left:20,right: 20,bottom: 40,top: 50),
        child:
        ListView(

          children: [
            Topbarlogin(),
            const SizedBox(
              height: 55,
            ),
            const Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),
            ),

            const SizedBox(
              height: 30,
            ),
            const Text("Sign up with one of the following options",style: TextStyle(color: Colors.grey),),
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
                Expanded(child: Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 1,
                  color: Colors.black,
                )),
                Text("Or"),
                Expanded(child: Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  thickness: 1,
                  color: Colors.black,
                )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
             Container(
              height:50,
             width: 500,
            padding: const EdgeInsets.only(left:20,right: 20),
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFE1E1E1),
               ),
              child:  TextField(
                controller: nameController,
               decoration:const InputDecoration(
                label: Text("Name"),
                 hintText: "Enter your Name",
                border: InputBorder.none,
                ) ,
              ),
             ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height:50,
              width: 500,
              padding: const EdgeInsets.only(left:20,right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE1E1E1),

              ),
              child:  TextField(
                controller: emailController,
                decoration:const InputDecoration(
                  label: Text("Email"),
                  hintText: "Enter your Email",
                  border: InputBorder.none,
                ) ,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height:50,
              width: 500,
              padding: const EdgeInsets.only(left:20,right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE1E1E1),

              ),
              child:  TextField(
                controller: passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(

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
                ) ,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height:50,
              width: 500,
              padding: const EdgeInsets.only(left:10,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Colors.red, Colors.purple]),

              ),
              child: TextButton(
                onPressed: () {
                  createAccount(context);
                },

                child: const Text("Create Account",style: TextStyle(color: Colors.white, fontSize: 17,),),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                TextButton(onPressed:() {
                  Navigator.pushNamed(context, Routes.loginscreen);
                }, child: const Text("Log In",
                    style: TextStyle(color: Colors.red)))
                // Text("Log in",style: TextStyle(color: Colors.red),),
              ],
            )

          ],
        ),
      ),
    );
  }
}