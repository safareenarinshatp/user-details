import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper{
Future addUserDetails(Map<String,dynamic> userInfoMap,String id) async{

  return await FirebaseFirestore.instance.collection("UserInfo").doc(id).set(userInfoMap);
}

Future<Stream<QuerySnapshot>>getAllusersInfo()async{

return await FirebaseFirestore.instance.collection("UserInfo").snapshots();

}



Future updateProfile(Map<String,dynamic> updateProfileMap,String id) async{

  return await FirebaseFirestore.instance.collection("UserInfo").doc(id).set(updateProfileMap);
}

Future deleteUser(String  id)async{


  return await FirebaseFirestore.instance.collection("UserInfo").doc(id).delete();
}

}










