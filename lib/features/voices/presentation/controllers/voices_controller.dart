import 'package:chorale_fva/features/voices/data/models/voice.dart';
import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class VoicesController extends GetxController {
  var voicesFields = Rxn<QuerySnapshot>();
  var isLoading = false.obs;
  
  final addVoiceController = TextEditingController();
  final editVoiceController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    await getVoices();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getVoices() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference voices = db.collection('voices');
    voicesFields.value = await voices.get();
    LoggerUtils.info(voicesFields.toString());
  }

  Future<void> addVoice(String name) async {
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
  }

  Future<void> updateVoice(Voice voice) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference voices = db.collection('voices');
    await voices.doc(voice.id).set(voice.toJson());
    editVoiceController.clear();
    await getVoices();  
  }

  Future<void> deleteVoice(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference voices = db.collection('voices');
    await voices.doc(id).delete();
    await getVoices();  
  }

}
