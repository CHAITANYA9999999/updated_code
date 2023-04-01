import 'package:punchmepartner/models/requests_m.dart';
import 'package:punchmepartner/utils/currency.dart';

String getServiceInfo(RequestM requestM) {
  return '${getCurrency(requestM.price)} -  ${requestM.doIt} · ${requestM.getIt}';
}
