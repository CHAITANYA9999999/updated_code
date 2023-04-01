import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:punchmepartner/models/service_m.dart';

abstract class ServicesRepo {
  Future<void> create(ServiceM serviceM, List<dynamic> images);
  Future<void> update(ServiceM serviceM, List<dynamic> images);
  Future<void> delete(ServiceM serviceM);
  Stream<QuerySnapshot> get();
}

class ServicesApis extends ServicesRepo {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // final uid = FirebaseAuth.instance.currentUser;
  final servicesStore = FirebaseFirestore.instance.collection('stores');
  final storesStorage = FirebaseStorage.instance.ref().child('services');

  String randomNumString() => new Random().nextInt(10000000).toString();

  Future<void> create(ServiceM serviceM, List<dynamic> images) async {
    serviceM.id = servicesStore.doc().id;
    serviceM.sid = uid;
    serviceM.images = await uploadImages(images);
    await servicesStore.doc(serviceM.id).set(serviceM.toJson());
  }

  Future<void> update(ServiceM serviceM, List<dynamic> images) async {}

  Future<List<String>> uploadImages(List<dynamic> fileImages) async {
    List<String> images = [];
    await Future.wait(fileImages.map((image) async {
      if (!(image is String)) {
        Reference ref = storesStorage.child('s' + randomNumString() + '.jpg');
        UploadTask uploadTask = ref.putFile(image);
        await uploadTask.then((snapshot) async {
          String url = await snapshot.ref.getDownloadURL();
          images.add(url);
        }).catchError((onError) {
          print(onError);
        });
      } else {
        images.add(image);
      }
    }));
    print(images);
    return images;
  }

  Future<void> delete(ServiceM serviceM) async {
    await servicesStore.doc(serviceM.id).delete();
  }

  @override
  Future<void> removeImage(String imageData) async {
    // await fb.storage().refFromURL(imageData).delete();
  }

  Stream<QuerySnapshot> get() async* {
    yield* servicesStore
        .orderBy('date', descending: true)
        .where('sid', isEqualTo: uid)
        .snapshots();
  }
}
