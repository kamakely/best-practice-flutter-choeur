import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../framework/utils/logger_utils.dart';

class MembersController extends GetxController {
  @override
  void onInit() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference members = db.collection('members');
    final DocumentSnapshot snapshot = await  members.doc('runtime').get();
    final membersFields = snapshot.data();
    LoggerUtils.info(membersFields.toString());
    super.onInit();
  }
}