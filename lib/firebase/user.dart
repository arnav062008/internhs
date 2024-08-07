import 'package:cloud_firestore/cloud_firestore.dart';

/// A class to represent a user with an email and uid.
class User {
  late String email;
  late String uid;
  String? country;
  int? searchRadius;
  bool? remote;
  int? age;

  /// Default Constructor
  User({required this.email, required this.uid}) {
    country = "United States";
    searchRadius = 50;
    remote = false;
    age = 10000;
  }

  /// Sets the email of the user and updates Firestore.
  Future<void> setEmail(String email) async {
    this.email = email;
    await addToFirestore();
  }

  /// Sets the uid of the user and updates Firestore.
  Future<void> setUid(String uid) async {
    this.uid = uid;
    await addToFirestore();
  }

  Future<void> addToFirestore() async {
    // Reference to the Firestore collection "user"
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    // Create or update the document with uid as the document ID
    await users.doc(uid).set({
      'email': email,
      'uid': uid,
    });
    await users
        .doc(uid)
        .collection("unliked")
        .doc("01888366524118fe")
        .set({'jobId': "01888366524118fe"});
    await users
        .doc(uid)
        .collection("wishlisted")
        .doc("01888366524118fe")
        .set({'jobId': "01888366524118fe"});
  }
}
