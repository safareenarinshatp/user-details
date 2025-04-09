
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:usersapplication/database.dart';
import 'package:usersapplication/flutterToast.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';






final _formKey=GlobalKey<FormState>();

class addUser extends StatefulWidget {
  const addUser({super.key});

  @override
  State<addUser> createState() => _addUserState();
}

class _addUserState extends State<addUser> {


String? uploadedImageUrl;

  


    final TextEditingController _emailController=TextEditingController();
  final TextEditingController _mobileNoController=TextEditingController();
  final TextEditingController _nameNoController=TextEditingController();

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


// String? isValidMobile(String? number) {
//   final RegExp mobileRegex = RegExp(r'^[0-9]{10}$');
//   final isNumValid=mobileRegex.hasMatch(number ?? '');
//   if(!isNumValid){
//     return ' Invalid mibile number';
//   }
//   return null;
// }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("Add user " ),centerTitle: true, ),

body: Container(
  margin: EdgeInsets.all(20),
  child: SingleChildScrollView(
    child: Form(

     key: _formKey,

      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
Center(
  child: Stack(
  children: [
  CircleAvatar(
  radius: 60,
  backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/profile-icon-white-background_941097-162627.jpg?w=900'),
  
  ),
  
  ],
  
  
  
  ),
),




 Text("Name",style: TextStyle(color: Colors.black,fontSize: 20),),
      SizedBox(height: 10,),
      TextFormField(
        controller: _nameNoController,
        keyboardType: TextInputType.text,
          validator: (value) {
          if (value == null || value.isEmpty) {
      return 'Please enter your name';
          }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(border: OutlineInputBorder(),
        label: Text(" name ")
        ),
       
      ),



      Text("Email",style: TextStyle(color: Colors.black,fontSize: 20),),
      SizedBox(height: 10,),
      TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(border: OutlineInputBorder(),
        label: Text(" email ")
        ),
       
      ),
      SizedBox(height: 10,),
      Text("Mobile",style: TextStyle(color: Colors.black,fontSize: 20),),
      SizedBox(height: 10,),
      TextFormField(
        controller: _mobileNoController,
       keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(border: OutlineInputBorder(),
        label: Text(" mobile no ")),
        validator: (value) {
          if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Mobile number must be exactly 10 digits';
          }
          return null;
        },
       
      ),
      SizedBox(height: 20,),
      
      
      SizedBox(width: double.infinity,
      child: Center(
        child: OutlinedButton(
          onPressed: () async{
          if(
         _formKey.currentState!.validate())
        {
        String Id=randomAlphaNumeric(10);
        String imageUrl='https://img.freepik.com/premium-photo/profile-icon-white-background_941097-162627.jpg?w=900';


        Map<String,dynamic>userInfoMap={
         
        "Email":_emailController.text,
        "Mobileno":_mobileNoController.text,
        "Name":_nameNoController.text,
        "Id":Id,
        "Imageurl":imageUrl,
        
        };
        await DatabaseHelper().addUserDetails(userInfoMap, Id).then((value){
          Message.Show(message: "Added successfully");
          print(  "image url is $imageUrl");
        });
             Navigator.pop(context);
        }
          }, child: Text("ADD",style: TextStyle(color: Colors.deepPurpleAccent),)),
      )
        
      
      ),
        ]
      ),
    ),
  ),
),
    );
  }
  
  
}