import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punchmepartner/models/store_m.dart';

abstract class RegisterRequestsRepo {
  Future<String> register(StoreM storeM);
}

class RegisterRequestsApis extends RegisterRequestsRepo {
  final registerRequestsStore =
      FirebaseFirestore.instance.collection('register-requests');

  Future<String> register(StoreM storeM) async {
    String id = registerRequestsStore.doc().id;
    await registerRequestsStore.doc(id).set(storeM.toJson());
    return id;
  }
}
