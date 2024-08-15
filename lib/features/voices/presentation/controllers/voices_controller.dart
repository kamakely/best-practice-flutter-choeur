import 'package:chorale_fva/features/voices/data/models/voice.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class VoicesController extends GetxController {
  var voicesFields = Rxn<QuerySnapshot>();
  var isFetching = false.obs;
  var isLoading = false.obs;

  final addVoiceController = TextEditingController();
  final editVoiceController = TextEditingController();

  var addVoiceErrorText = Rxn<String>();
  var editVoiceErrorText = Rxn<String>();

  @override
  void onInit() async {
    isFetching.value = true;
    await getVoices();
    isFetching.value = false;
    super.onInit();
  }

  Future<void> getVoices() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference voices = db.collection('voices');
    voicesFields.value = await voices.get();
    LoggerUtils.info(voicesFields.toString());
  }

  Future<bool> addVoice(String name,) async {
    addVoiceErrorText.value = null;
    if (addVoiceController.text.isNotEmpty) {
      isLoading.value = true;
      var uuid = const Uuid();
      final id = uuid.v4();
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference voices = db.collection('voices');
      await voices.doc(id).set(Voice(
            id: id,
            name: name,
          ).toJson());
      addVoiceController.clear();
      await getVoices();
      isLoading.value = false;
      return true;
    } else {
      addVoiceErrorText.value = 'Veuillez remplir ce champs';
    }
    return false;
  }

  Future<bool> updateVoice(Voice voice) async {
    editVoiceErrorText.value = null;
    if (editVoiceController.text.isNotEmpty) {
      isLoading.value = true;
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final CollectionReference voices = db.collection('voices');
      await voices.doc(voice.id).set(voice.toJson());
      editVoiceController.clear();
      await getVoices();
      isLoading.value = false;
      return true;
    } else {
      editVoiceErrorText.value = 'Veuillez remplir ce champs';
    }
    return false;
  }

  Future<void> deleteVoice(String id) async {
    isLoading.value = true;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference voices = db.collection('voices');
    await voices.doc(id).delete();
    await getVoices();
    isLoading.value = false;
  }

  void initData() {
    addVoiceErrorText.value = null;
    addVoiceController.clear();

    editVoiceErrorText.value = null;
    editVoiceController.clear();
  }
}
