import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection = Firestore.instance.collection("brews");

  Future updateUser(String sugars, String name, int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

List<Brew> _brewListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
          name : doc.data['name'] ?? '',
          sugars : doc.data['sugars'] ?? '0',
          strength : doc.data['strength'] ?? 0
      );
    });
}

//user data from snapshot
  UserData _userDataListFromSnapshot (DocumentSnapshot snapshot){
      return UserData(
          uid: uid,
          name : snapshot.data['name'],
          sugars : snapshot.data['sugars'],
          strength : snapshot.data['strength']
      );
  }

  Stream<List<Brew>> get brew{
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDataListFromSnapshot);
  }

}