// lib/services/firestore_service.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  FirestoreService._private();
  static final instance = FirestoreService._private();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');
    return user.uid;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userDocStream() {
    return _fs.collection('users').doc(uid).snapshots();
  }

  Future<void> createOrUpdateUserProfile(Map<String, dynamic> data) async {
    await _fs.collection('users').doc(uid).set(
      {
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> familyStream() {
    return _fs
        .collection('users')
        .doc(uid)
        .collection('family_members')
        .orderBy('name')
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addFamilyMember(
      Map<String, dynamic> data) async {
    return await _fs
        .collection('users')
        .doc(uid)
        .collection('family_members')
        .add({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateFamilyMember(String docId, Map<String, dynamic> data) async {
    await _fs
        .collection('users')
        .doc(uid)
        .collection('family_members')
        .doc(docId)
        .set({...data, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
  }

  Future<void> deleteFamilyMember(String docId) async {
    await _fs
        .collection('users')
        .doc(uid)
        .collection('family_members')
        .doc(docId)
        .delete();
  }

  Future<String> uploadImageFile(File file, {String? pathSuffix}) async {
    final ref = _storage.ref().child('users/$uid/${DateTime.now().millisecondsSinceEpoch}${pathSuffix ?? ''}');
    final uploadTask = ref.putFile(file);
    final snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }
}
