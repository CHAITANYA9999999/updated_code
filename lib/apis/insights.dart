import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:punchmepartner/models/store_m.dart';
import 'package:punchmepartner/models/user_m.dart';

abstract class InsightsRepo {
  Future<UserM> getUsers(String id);
}

class InsightsApis extends InsightsRepo {
  final auth = FirebaseAuth.instance;
  final userStore = FirebaseFirestore.instance.collection('users');

  @override
  Future<UserM> getUsers(String id) async {
    final data = await userStore.doc(id).get();
    return UserM.fromJson(data.data()!);
  }
}
