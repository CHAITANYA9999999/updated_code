import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:punchmepartner/models/request_history_m.dart';
import 'package:punchmepartner/models/requests_m.dart';

abstract class RequestsRepo {
  Future<void> update(
    RequestM requestM,
    RequestHistoryM requestHistoryM,
    Map<String, dynamic> serviceHistoryM,
  );
  Future<void> delete(
    RequestM requestM,
  );
  Stream<QuerySnapshot> get();
}

class RequestsApis extends RequestsRepo{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  
  
  final requestsStore = FirebaseFirestore.instance.collection('requests');
  final serviceStore = FirebaseFirestore.instance.collection('stores');
  final usersStore = FirebaseFirestore.instance.collection('users');
  final requestsHistoriesStore =
      FirebaseFirestore.instance.collection('requests_histories');

  Future<void> update(RequestM requestM, RequestHistoryM requestHistoryM,
      Map<String, dynamic> serviceHistoryM) async {
    final batch = FirebaseFirestore.instance.batch();
    batch.update(requestsStore.doc(requestM.id), requestM.toJson());
    if (requestM.punch) {
      batch.set(
          usersStore.doc(requestM.uid).collection('punches').doc(requestM.sid),
          serviceHistoryM,
          SetOptions(merge: true));
    } else {
      batch.set(
          usersStore.doc(requestM.uid).collection('points').doc(requestM.oid),
          serviceHistoryM,
          SetOptions(merge: true));
    }
    batch.set(
        requestsHistoriesStore.doc(requestM.id), requestHistoryM.toJson());
    if (requestM.status) {
      batch.set(
          serviceStore
              .doc(requestM.sid)
              .collection('user_data')
              .doc(requestM.uid),
          serviceHistoryM,
          SetOptions(merge: true));
    }
    await batch.commit();
  }

  Future<void> delete(RequestM requestM) async {
    await requestsStore.doc(requestM.id).delete();
  }

  Stream<QuerySnapshot> get() async* {
    yield* requestsStore
        .orderBy('date', descending: true)
        .where('oid', isEqualTo: uid)
        .snapshots();
  }
}
