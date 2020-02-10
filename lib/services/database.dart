import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lgoin/models/user.dart';
import 'package:lgoin/models/userField.dart';
import 'package:random_string/random_string.dart';



class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userField = Firestore.instance.collection("eclubIITK");

  Future updateUserData (String name ,String email) async{
    return await userField.document(uid).setData({
      'Name' : name,
      'Email': email,
      'Password' : randomString(15),
     
    }); //create and link document with uid
  }
  
  //name from snapshot
  List<EclubUser> _nameEmailFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return EclubUser(
        name : doc.data["Name"] ?? "Not Found",
        email: doc.data["Email"] ?? "Not FOUND",
        password: doc.data["Password"] ?? "Not Found",
      );
    }).toList();
  }

  //user data from snapshots

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data["Name"],
      email: snapshot.data["Email"],
      password: snapshot.data["Password"],
    );
  }
  //stream
  Stream<List<EclubUser>> get eclubIITK{
    return userField.snapshots()
    .map(_nameEmailFromSnapshot);
  }

  //get user doc sstream
  Stream<UserData> get userData {
    return userField.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}