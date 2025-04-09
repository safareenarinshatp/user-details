import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:usersapplication/authService.dart';
import 'package:usersapplication/firebase_options.dart';
import 'package:usersapplication/homepage.dart';
import 'package:usersapplication/loginPage.dart';
import 'package:usersapplication/signupPage.dart';

void main()  async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
"/":(context)=>checkUser(),
"/login":(context)=>Loginscreen(),
"/home":(context)=>UserProfile(),
"/signup":(context)=>signUpScreen()

      },
    );
  }
}



class checkUser extends StatefulWidget {
  const checkUser({super.key});

  @override
  State<checkUser> createState() => _checkUserState();
}

class _checkUserState extends State<checkUser> {

  @override
  void initState() {
    AuthserviceHelper.isUserLoggedin().then((value){
if(value){

  Navigator.pushReplacementNamed(context, "/home");
}else{

  Navigator.pushReplacementNamed(context, "/login");
}

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}