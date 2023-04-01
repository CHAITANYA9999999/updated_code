import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:punchmepartner/models/store_m.dart';

abstract class AuthRepo {
  Future<UserCredential> login(String email, String password);
  Future<StoreM> getStoreDetails(); 
  Future<void> updateStoreDetails(Map<String, dynamic> data);
  Future<void> sendPasswordResetLink(String email);
}

class AuthApis extends AuthRepo {
  final auth = FirebaseAuth.instance;
  final userStore = FirebaseFirestore.instance.collection('stores');

  @override
  Future<UserCredential> login(String email, String password) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<StoreM> getStoreDetails() async {
    final data = await userStore.doc(auth.currentUser!.uid).get();
    return StoreM.fromJson(data.data()!);
  }

  @override
  Future<void> updateStoreDetails(Map<String, dynamic> data) async {
    await userStore.doc(auth.currentUser!.uid).update(data);
  }

  @override
  Future<void> sendPasswordResetLink(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
