import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of profiles
  static final CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');

  // CREATE: Add a new profile
Future<void> addProfile(String name, List<String> options) {
  return profiles.add({
    'name': name,
    'options': options.toList(),
  });
}

  //READ (profile names): get the profile names from database

  // READ (profile): get a profile from database
  Stream<QuerySnapshot> getProfileStream() {
    final profileStream = profiles.orderBy('name', descending: true).snapshots();
    return profileStream;
  }

  // UPDATE: update profiles given a profile id

  // DELETE: delete profiles given a profile id


}