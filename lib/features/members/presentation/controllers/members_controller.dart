import 'dart:io';

import 'package:chorale_fva/features/members/data/models/member.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../../voices/data/models/voice.dart';

class MembersController extends GetxController {
  String membersCollection = 'members';
  var membersFields = Rxn<QuerySnapshot>();
  var voicesFields = Rxn<QuerySnapshot>();
  var voices = <Voice>[].obs;
  var isLoading = false.obs;
  var isGettingVoices = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final churchController = TextEditingController();
  final groupController = TextEditingController();
  final remarkController = TextEditingController();
  var voiceValue = Rxn<Voice>();
  var profilUrl = Rxn<String>();

  final editMemberController = TextEditingController();

  var photo = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void onInit() async {
    isLoading.value = true;
    await getMembers();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getMembers() async {
    membersFields.value =
        await FirebaseFirestore.instance.collection(membersCollection).get();
    LoggerUtils.info(membersFields.toString());
  }

  Future<void> getVoices() async {
    isGettingVoices.value = true;
    voices.clear();
    voicesFields.value =
        await FirebaseFirestore.instance.collection('voices').get();
    voices.value = voicesFields.value!.docs.map((doc) {
      return Voice.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
    isGettingVoices.value = false;
    LoggerUtils.info(voicesFields.toString());
  }

  void handleChangeVoiceValue(Voice? voice) {
    voiceValue.value = voice;
  }

  Future<void> imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo.value = File(pickedFile.path);
      await uploadFile();
    }
  }

  Future<void> imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      photo.value = File(pickedFile.path);
      await uploadFile();
    } else {
      LoggerUtils.error('No image selected.');
    }
  }

  Future uploadFile() async {
    if (photo.value == null) return;
    final fileName = basename(photo.value!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(photo.value!);
      profilUrl.value = await ref.getDownloadURL();
    } catch (e) {
      LoggerUtils.error('error occured');
    }
  }

  Future<void> addMember() async {
    var uuid = const Uuid();
    final id = uuid.v4();
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference members = db.collection(membersCollection);
    await members.doc(id).set(Member(
          id: id,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phone: phoneController.text,
          email: emailController.text,
          address: addressController.text,
          church: churchController.text,
          group: groupController.text,
          remarkMember: remarkController.text,
          voiceId: voiceValue.value?.id ?? voices.first.id,
          profilUrl: profilUrl.value,
        ).toJson());
    await getMembers();
  }

  void clearForms() {
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    churchController.clear();
    groupController.clear();
    remarkController.clear();
    profilUrl.value = null;
  }

  Future<void> updateMember(Member member) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference members = db.collection(membersCollection);
    await members.doc(member.id).set(member.toJson());
    editMemberController.clear();
    await getMembers();
  }

  Future<void> deleteMember(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference members = db.collection(membersCollection);
    await members.doc(id).delete();
    await getMembers();
  }
}
