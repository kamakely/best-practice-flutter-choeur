import 'package:chorale_fva/features/voices/data/models/voice.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/role.dart';

class RolesController extends GetxController {
  var rolesFields = Rxn<QuerySnapshot>();
  var isLoading = false.obs;
  
  final addRoleController = TextEditingController();
  final editRoleController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    await getRoles();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getRoles() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    rolesFields.value = await roles.get();
    LoggerUtils.info(rolesFields.toString());
  }

  Future<void> addRole(String name) async {
    var uuid = const Uuid();
    final id = uuid.v4();
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    await roles.doc(id).set(Voice(
          id: id,
          name: name,
        ).toJson());
    addRoleController.clear();    
    await getRoles();    
  }

  Future<void> updateRole(Role role) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    await roles.doc(role.id).set(role.toJson());
    editRoleController.clear();
    await getRoles();  
  }

  Future<void> deleteRole(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    await roles.doc(id).delete();
    await getRoles();  
  }

}
