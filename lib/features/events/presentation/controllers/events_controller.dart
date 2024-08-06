import 'package:chorale_fva/framework/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../framework/utils.dart';
import '../../data/models/event.dart';

class EventsController extends GetxController {
  var eventsFields = Rxn<QuerySnapshot>();
  var isLoading = false.obs;

  final addEventController = TextEditingController();
  final editEventController = TextEditingController();
  final dateEventController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    await getEvents();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getEvents() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference events = db.collection('events');
    eventsFields.value = await events.get();
    LoggerUtils.info(eventsFields.toString());
  }

  Future<void> addEvent() async {
    var uuid = const Uuid();
    final id = uuid.v4();
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference events = db.collection('events');
    await events.doc(id).set(Event(
          id: id,
          name: addEventController.text,
          date: Utils.dateTimeFromString(dateEventController.text) ??
              DateTime.now(),
        ).toJson());
    addEventController.clear();
    await getEvents();
  }

  Future<void> updateEvent(Event event) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference voices = db.collection('events');
    await voices.doc(event.id).set(event.toJson());
    editEventController.clear();
    await getEvents();
  }

  Future<void> deleteVoice(String id) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference events = db.collection('events');
    await events.doc(id).delete();
    await getEvents();
  }
}
