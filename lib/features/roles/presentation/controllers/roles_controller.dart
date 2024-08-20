import 'package:chorale_fva/features/voices/data/models/voice.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/role.dart';

class RolesController extends GetxController {
  var rolesFields = Rxn<QuerySnapshot>();
  var isFetching = false.obs;
  var isLoading = false.obs;

  final addRoleController = TextEditingController();
  final editRoleController = TextEditingController();

  var addRoleErrorText = Rxn<String>();
  var editRoleErrorText = Rxn<String>();

  @override
  void onInit() async {
    isFetching.value = true;
    await getRoles();
    isFetching.value = false;
    super.onInit();
  }

  Future<void> getRoles() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    rolesFields.value = await roles.get();
    LoggerUtils.info(rolesFields.toString());
  }

  Future<bool> addRole(String name) async {
    addRoleErrorText.value = null;
    if (addRoleController.text.isNotEmpty) {
      isLoading.value = true;
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
      isLoading.value = false;
      return true;
    } else {
      addRoleErrorText.value = 'Veuillez remplir ce champs';
    }
    return false;
  }

  Future<bool> updateRole(Role role) async {
    editRoleErrorText.value = null;
    if (editRoleController.text.isNotEmpty) {
      isLoading.value = true;
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference roles = db.collection('roles');
      await roles.doc(role.id).set(role.toJson());
      editRoleController.clear();
      await getRoles();
      isLoading.value = false;
      return true;
    } else {
      editRoleErrorText.value = 'Veuillez remplir ce champs';
    }
    return false;
  }

  Future<void> deleteRole(String id) async {
    isLoading.value = true;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference roles = db.collection('roles');
    await roles.doc(id).delete();
    await getRoles();
    isLoading.value = false;
  }

  void initData() {
    addRoleErrorText.value = null;
    addRoleController.clear();

    editRoleErrorText.value = null;
    editRoleController.clear();
  }
}
