import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:punchmepartner/apis/auth.dart';
import 'package:punchmepartner/apis/requests.dart';
import 'package:punchmepartner/models/request_history_m.dart';
import 'package:punchmepartner/models/requests_m.dart';
import 'package:punchmepartner/overlays/progress_dialog.dart';
import 'package:punchmepartner/overlays/snackbar.dart';
import 'package:punchmepartner/utils/date_time.dart';

class RequestsController extends GetxController {
  RequestsRepo requestsRepo = RequestsApis();
  AuthRepo authRepo = AuthApis();

  Future<void> updateRequest(RequestM requestM, bool status) async {
    try {
      isLoading(true);
      requestM.status = status;
      final requestHistoryM = RequestHistoryM(
          date: setDate(),
          oid: requestM.oid,
          storeName: requestM.storeName,
          uid: requestM.uid,
          userName: requestM.userName,
          serviceName: requestM.serviceName,
          status: status,
          sid: requestM.sid);
      var serviceHistoryM;
      if (requestM.punch) {
        serviceHistoryM = {
          'date': setDate(),
          'offer_name': requestM.serviceName,
          'do_it': requestM.doIt,
          'uid': requestM.uid,
          'sid': requestM.sid,
          'user_name': requestM.userName,
          'lapse': FieldValue.arrayUnion([setDate()])
        };
      } else {
        serviceHistoryM = {
          'date': setDate(),
          'uid': requestM.uid,
          'oid': requestM.oid,
          'store_name': requestM.storeName,
          'user_name': requestM.userName,
          'total': FieldValue.increment(1)
        };
      }

      await requestsRepo.update(requestM, requestHistoryM, serviceHistoryM);
      if (status) {
        final data = {
          'users': FieldValue.arrayUnion([requestM.uid])
        };
        await authRepo.updateStoreDetails(data);
      }

      isLoading(false);
      if (status) {
        JxSnackBarStatus(
            'Confirmation',
            (requestM.punch ? 'Punched to ' : 'Points collected by ') +
                requestM.userName);
      }

      Future.delayed(Duration(seconds: 4), () async {
        await requestsRepo.delete(requestM);
      });
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  Stream<QuerySnapshot> get() async* {
    yield* requestsRepo.get();
  }
}

void sample() {
  try {
    isLoading(true);
    isLoading(false);
  } catch (e) {
    print(e);
    isLoading(false);
  }
}
