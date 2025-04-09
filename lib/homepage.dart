

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:usersapplication/addUserDetails.dart';
import 'package:usersapplication/authService.dart';
import 'package:usersapplication/database.dart';
import 'package:usersapplication/flutterToast.dart';



class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


String? imageUrl='https://img.freepik.com/premium-photo/profile-icon-white-background_941097-162627.jpg?w=900';

    final TextEditingController _emailController=TextEditingController();
  final TextEditingController _mobileNoController=TextEditingController();
  final TextEditingController _nameNoController=TextEditingController();

final _formKey=GlobalKey<FormState>();


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


Stream? userStream;


dynamic getAllusers()async{

  userStream= await DatabaseHelper().getAllusersInfo();
  setState(() {
    
  });
}
@override
void initState(){
getAllusers();
super.initState();

}



Widget allUsersInfo(){

return StreamBuilder(
   builder: (context, AsyncSnapshot snapshot){
return snapshot.hasData? ListView.builder(
  itemCount: snapshot.data.docs.length,
  
  itemBuilder: (context,index){
DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
return SingleChildScrollView(

child: Container(

  margin: EdgeInsets.only(bottom: 20),
  child: Material(

    elevation: 5,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 10),
         width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
                      color:Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
          child:Column(

crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(

children: [

// CircleAvatar(
//                 radius: 40,
//                 backgroundImage: NetworkImage(documentSnapshot["Imageurl"] ),
//               ),
//               SizedBox(width: 15),


CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl ?? ''),
              ),
              SizedBox(width: 15),


  SizedBox( width: 200,),
  InkWell(
    
    onTap: (){
_nameNoController.text=documentSnapshot["Name"];
_emailController.text=documentSnapshot["Email"];
_mobileNoController.text=documentSnapshot["Mobileno"];
// imageUrl=documentSnapshot["Imageurl"];
editProfile(documentSnapshot["Id"]);

    },
    
    child: Icon(Icons.edit)),

    SizedBox(width: 10,),
   InkWell(
    onTap: (){

      deleteConfirmationDialog(context, documentSnapshot["Id"]);
    },
    child: Icon(Icons.delete)),

],


),
SizedBox(height: 10,),
Text("Name:${documentSnapshot["Name"]}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20)),
Text('Email:${documentSnapshot["Email"]}',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20)),
Text("Mob:${documentSnapshot["Mobileno"]}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20)),


],


          ) ,


    ),
  ),
),

);
  }
  
  ):

Container();

   },
   stream: userStream,
   );

}




  @override
  Widget build(BuildContext context) {
    return SafeArea(


      
      child: Scaffold(
        
        appBar:AppBar(title: Text("ALL PROFILES"), centerTitle: true,
        
        actions: [
  IconButton(
    onPressed: () async{
logoutConfirmationDialog(context);
    },
   icon: Icon(Icons.login_outlined))
],
        ),
        
      body: Center(
      
      
        child: Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 30),
      child: Column(
      children: [
      Expanded(
        child: allUsersInfo())
      
      ],
      
      ),
      
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>addUser()));
      
        },
      tooltip: 'Add',
      child: const  Icon(Icons.add),
      ),
      ),
    );
  }



 Future editProfile(String Id){
return showDialog(
  context: context,
 builder: (context)=>AlertDialog(

content: SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Align(
      alignment: Alignment.center,
      child: Text('Update Profile',style: TextStyle( color: Theme.of(context).primaryColor,  fontSize: 30,fontWeight: FontWeight.bold)
      ),
    ),
    SizedBox(height: 15,),
    Divider( height: 10,thickness: 5,  color:Theme.of(context).primaryColor,),
   SizedBox(height: 15,),
    

Container(
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
                radius: 40,
                backgroundImage: NetworkImage(imageUrl ?? ''),
              ),
              SizedBox(width: 15),
  
  ],
  
  
  
  ),
),




 Text("Name",style: TextStyle(color: Colors.black,fontSize: 20),),
      SizedBox(height: 10,),
      TextFormField(
        controller: _nameNoController,
        keyboardType: TextInputType.text,
          
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
      child: Row(
        children:[ OutlinedButton(
          onPressed: () async{
          if(
         _formKey.currentState!.validate())
        {

        Map<String,dynamic>updateProfileMap={
         
        "Email":_emailController.text,
        "Mobileno":_mobileNoController.text,
        "Name":_nameNoController.text,
        "Id":Id
        
        
        };
        await DatabaseHelper().updateProfile(updateProfileMap, Id).then((value){
          Message.Show(message: "Updated successfully");
        });
             Navigator.pop(context);
        }
          }, 
        child: Text("Update",style: TextStyle(color: Colors.deepPurpleAccent),)),
SizedBox( width: 10,),
        OutlinedButton(onPressed: (){
 Navigator.pop(context);
        }, child: Text("Close",style: TextStyle(color: Colors.deepPurpleAccent)))
        ]
      )
        
      
      ),
        ]
      ),
    ),
  ),
),
  ],


  ),
)

 )
 );

 


}







void deleteConfirmationDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () async {
              await DatabaseHelper().deleteUser(id);
              Message.Show(message: 'Deleted  successfully');
  Navigator.pop(context);
            },
            child: Text('Yes'),
          ), // TextButton
          TextButton(
            onPressed: () {

              Navigator.pop(context);
            },
            child: Text('No'),
          ), // TextButton
        ],
      );
    }
  );
}



void logoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to logout this account?'),
        actions: [
          TextButton(
            onPressed: () async {
             await AuthserviceHelper.logout().then((value){
              Message.Show(message: 'Account logout successfully');

             });
            Navigator.pushReplacementNamed(context, "/login");
             
  
            },
            child: Text('Yes'),
          ), // TextButton
          TextButton(
            onPressed: () {

              Navigator.pop(context);
            },
            child: Text('No'),
          ), // TextButton
        ],
      );
    }
  );
}





}
