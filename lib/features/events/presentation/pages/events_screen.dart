import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../framework/utils.dart';
import '../../data/models/event.dart';
import '../controllers/events_controller.dart';
import '../controllers/voices_binding.dart';
import '../widgets/add_event_bottomsheet.dart';

class EventsScreen extends GetView<EventsController> {
  const EventsScreen({super.key});

  Widget _body() {
    return Obx(() {
      bool isDataEmpty = controller.eventsFields.value == null ||
          controller.eventsFields.value!.docs.isEmpty;

      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }

      if (isDataEmpty) {
        return const Center(
          child: Text('Aucune donnée'),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 40.h,
        ),
        child: ListView.builder(
            itemCount: controller.eventsFields.value!.docs.length,
            itemBuilder: (context, index) {
              var doc = controller.eventsFields.value!.docs[index];
              return Card(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0.w,
                  vertical: 16.0.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.event_note_rounded,
                              size: 35.h,
                            ),
                            Gap(20.w),
                            Text((doc.data() as Map)['name']),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              size: 35.h,
                            ),
                            Gap(20.w),
                            Text(Utils.dateTimeToString(
                                    (doc.data() as Map)['date'].toDate()) ??
                                ''),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: AppColors.backgroundColor,
                                isScrollControlled: true,
                                builder: (_) {
                                  controller.editEventController.text =
                                      (doc.data() as Map)['name'];
                                  controller.dateEventController.text =
                                      Utils.dateTimeToString(
                                              (doc.data() as Map)['date']
                                                  .toDate()) ??
                                          '';
                                  return FractionallySizedBox(
                                      heightFactor: 0.7,
                                      widthFactor: 0.95,
                                      child: AddEventBottomsheet(
                                        title: 'Modifier une événement : ',
                                        nameController:
                                            controller.editEventController,
                                        dateController:
                                            controller.dateEventController,
                                        buttonTitle: 'Modifier',
                                        onAdd: () {
                                          controller
                                              .updateEvent(Event(
                                            id: (doc.data() as Map)['id'],
                                            name: controller
                                                .editEventController.text,
                                            date: Utils.dateTimeFromString(
                                                    controller
                                                        .dateEventController
                                                        .text) ??
                                                DateTime.now(),
                                          ))
                                              .then((_) {
                                            Navigator.pop(context);
                                          });
                                        },
                                      ));
                                },
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              await controller
                                  .deleteVoice((doc.data() as Map)['id']);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    )
                  ],
                ),
              ));
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    EventsBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Evénément'),
          backgroundColor: const Color(0xFF62D9F7),
          actions: [
            IconButton(
              onPressed: () async {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: AppColors.backgroundColor,
                  isScrollControlled: true,
                  builder: (_) {
                    return FractionallySizedBox(
                        heightFactor: 0.7,
                        widthFactor: 0.95,
                        child: AddEventBottomsheet(
                          title: 'Ajouter un événement : ',
                          nameController: controller.addEventController,
                          dateController: controller.dateEventController,
                          buttonTitle: 'Ajouter',
                          onAdd: () {
                            controller.addEvent().then((_) {
                              Navigator.pop(context);
                            });
                          },
                        ));
                  },
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            )
          ],
        ),
        body: _body());
  }
}
