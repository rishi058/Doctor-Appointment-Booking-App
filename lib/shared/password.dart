import 'package:cloud_firestore/cloud_firestore.dart';

class Password{

  String uid = "mMlRkNxpx3Lodrdr3ewn";

  Future<String> getAdmin() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('password')
        .doc(uid)
        .get();

    var data = snapshot.data() as Map<String,dynamic> ;
    return data['admin'] ;
  }

  Future<String> getSupervisor() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('password')
        .doc(uid)
        .get();

    var data = snapshot.data() as Map<String,dynamic> ;
    return data['supervisor'] ;
  }

  Future<String> getStaff() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('password')
        .doc(uid)
        .get();

    var data = snapshot.data() as Map<String,dynamic> ;
    return data['staff'] ;
  }

}