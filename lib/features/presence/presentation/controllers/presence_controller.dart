import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../framework/utils/logger_utils.dart';

class PresenceController extends GetxController {
  @override
  void onInit() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference presence = db.collection('presence');
    final DocumentSnapshot snapshot = await  presence.doc('runtime').get();
    final presenceFields = snapshot.data();
    LoggerUtils.info(presenceFields.toString());
    super.onInit();
  }
}