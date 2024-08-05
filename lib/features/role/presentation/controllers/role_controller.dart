import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../framework/utils/logger_utils.dart';

class RoleController extends GetxController {
   @override
  void onInit() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    final DocumentSnapshot snapshot = await  roles.doc('runtime').get();
    final rolesFields = snapshot.data();
    LoggerUtils.info(rolesFields.toString());
    super.onInit();
  }
}