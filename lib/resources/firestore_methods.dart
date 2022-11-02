import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings')
      .orderBy(
        'createdDate',
        descending: true,
      )
      .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get userList => _firestore
      .collection('users')
      .where('uID', isNotEqualTo: _auth.currentUser!.uid)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userInfo =>
      _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots();

  void addMeetingHistory(String meetingName, String roomID) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetingName': meetingName,
        'roomID': roomID,
        'createdDate': DateTime.now(),
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
