import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/flutter_base.dart';

import 'firebase_auth_exeptions.dart';

final firebaseService = FirebaseService.instance;

class FirebaseService {
  FirebaseService._();

  static FirebaseService get instance => FirebaseService._();

  final firebaseAuth = FirebaseAuth.instance;
  static const users = "users";
  static const todos = "todos";

  User get currentUser => firebaseAuth.currentUser!;

  CollectionReference get allUsersRef => FirebaseFirestore.instance.collection(users);

  DocumentReference get currentUserRef => FirebaseFirestore.instance.collection(users).doc(currentUser.uid);

  CollectionReference get currentUsersTodoRef =>
      FirebaseFirestore.instance.collection(users).doc(currentUser.uid).collection(todos);

  Stream<QuerySnapshot> todosStream() => currentUserRef.collection(todos).orderBy('index').snapshots();

  Future<dynamic> signInAnonymously() async {
    try {
      final user = (await FirebaseAuth.instance.signInAnonymously()).user;
      return user;
    } on FirebaseAuthException catch (e, stackTrace) {
      showLog("signInAnonymously exception =====>>> $e");
      showLog("signInAnonymously exception stackTrace =====>>> $stackTrace");

      final code = AuthExceptionHandler.handleException(e);
      showLog("signInAnonymously =====>>> $code");
      return AuthExceptionHandler.generateExceptionMessage(code);
    }
  }

  Future<dynamic> updateDataOnFirestore(Map<String, dynamic> data) async {
    try {
      currentUserRef.set(data, SetOptions(merge: true));
    } catch (e, stackTrace) {
      showLog("updateDataOnFirestore exception =====>>> $e");
      showLog("updateDataOnFirestore exception stackTrace =====>>> $stackTrace");
    }
  }

  Future<dynamic> createNewTodo(Map<String, dynamic> data) async {
    try {
      showLoader();
      final doc = await currentUsersTodoRef.add(data);

      /// add newly created doc id to to-do document.
      updateTodo(doc.id, {"id": doc.id});
      hideLoader();
      return true;
    } catch (e) {
      showLog("createNewTodo exception ======>> $e");
    }
    return false;
  }

  Future<dynamic> updateTodo(String id, Map<String, dynamic> data) async {
    try {
      await currentUsersTodoRef.doc(id).set(data, SetOptions(merge: true));
      return true;
    } catch (e) {
      showLog("updateTodo exception ======>> $e");
    }

    return false;
  }
}
