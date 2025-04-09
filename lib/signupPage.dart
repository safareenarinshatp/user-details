
import 'package:flutter/material.dart';
import 'package:usersapplication/authService.dart';
import 'package:usersapplication/flutterToast.dart';



final _formKey=GlobalKey<FormState>();


class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {

TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();


String? validateEmail(String? email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  final isEmailValid=emailRegex.hasMatch(email ?? '');
  if(!isEmailValid){
    return'Please enter a valid email';

  }
  return null;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Form(
  key: _formKey,
  child: Center(
    child: Padding(padding: EdgeInsets.all(10),
    child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Align(
    alignment: Alignment.center,
    child: Text("SIGN UP",style: TextStyle( fontWeight: FontWeight.w800,fontSize: 30),)),
  SizedBox(height: 20,),
  TextFormField(
   controller: emailController,
   validator: validateEmail,
     autovalidateMode: AutovalidateMode.onUserInteraction,
     keyboardType: TextInputType.emailAddress,
   decoration: InputDecoration(
    border: OutlineInputBorder(),
    label: Text("Email"),
    hintText: "Enter your email"
   ),
  
  ),
  SizedBox(height: 10,),
  
  TextFormField(
   controller: passwordController,
   decoration: InputDecoration(
    border: OutlineInputBorder(),
    label: Text("Password"),
    hintText: "Enter your password"
   ),
  
  ),
  SizedBox(height: 10,),
  SizedBox(width: double.infinity,
  height: 45,
  child: OutlinedButton(
    onPressed: ()async{
  await AuthserviceHelper.createAccountwithemail(emailController.text, passwordController.text).then((value){
  if(value=="Account create successfully"){
  
    Message.Show(message: "Account created successfully");
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route)=>false);
  }
  else{
  
    Message.Show(message: "Error:$value");
  }
  });
  
    }, 
  child: Text("Sign Up")),
  ),
  SizedBox(height: 10,),
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("already have  an account?"),
      TextButton(
        onPressed: (){
  Navigator.pop(context);
        }, 
        child: Text("Login"))
    ],
  ),
  ],
    ),
    ),
  
    
  ),
),
    );
  }
}