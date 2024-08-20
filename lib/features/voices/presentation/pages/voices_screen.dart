import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:chorale_fva/features/voices/data/models/voice.dart';
import 'package:chorale_fva/framework/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/voices_binding.dart';
import '../controllers/voices_controller.dart';
import '../../../../framework/widgets/add_bottomsheet.dart';

class VoicesScreen extends GetView<VoicesController> {
  const VoicesScreen({super.key});

  Widget _body(BuildContext context) {
    return Obx(() {
      bool isDataEmpty = controller.voicesFields.value == null ||
          controller.voicesFields.value!.docs.isEmpty;

      if (controller.isFetching.value) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }

      if (isDataEmpty) {
        return const NoDataScreen();
      }

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 40.h,
        ),
        child: ListView.builder(
            itemCount: controller.voicesFields.value!.docs.length,
            itemBuilder: (context, index) {
              var doc = controller.voicesFields.value!.docs[index];
              return Card(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0.w,
                  vertical: 16.0.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((doc.data() as Map)['name']),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: AppColors.backgroundColor,
                                isScrollControlled: true,
                                builder: (_) {
                                  controller.editVoiceController.text =
                                      (doc.data() as Map)['name'];
                                  return FractionallySizedBox(
                                      heightFactor: 0.7,
                                      widthFactor: 0.95,
                                      child: Obx(
                                        () => AddBottomsheet(
                                          title:
                                              "Modifier une section d'un choeur : ",
                                          controller:
                                              controller.editVoiceController,
                                          buttonTitle: 'Modifier',
                                          prefixIcon: Icon(
                                            Icons.music_note_outlined,
                                            size: 50.h,
                                            color: controller.editVoiceErrorText
                                                        .value !=
                                                    null
                                                ? AppColors.red500
                                                : null,
                                          ),
                                          isLoading: controller.isLoading.value,
                                          errorText: controller
                                              .editVoiceErrorText.value,
                                          onAdd: () {
                                            controller
                                                .updateVoice(Voice(
                                                    id: (doc.data()
                                                        as Map)['id'],
                                                    name: controller
                                                        .editVoiceController
                                                        .text))
                                                .then((isOk) {
                                              if (isOk) {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                        ),
                                      ));
                                },
                              );
                              controller.initData();
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
    VoicesBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Voix',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: const Color(0xFF62D9F7),
          actions: [
            IconButton(
              onPressed: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: AppColors.backgroundColor,
                  isScrollControlled: true,
                  builder: (_) {
                    return FractionallySizedBox(
                        heightFactor: 0.7,
                        widthFactor: 0.95,
                        child: Obx(
                          () => AddBottomsheet(
                            title: "Ajouter une section d'un choeur : ",
                            controller: controller.addVoiceController,
                            buttonTitle: 'Ajouter',
                            prefixIcon: Icon(
                              Icons.music_note_outlined,
                              size: 50.h,
                              color: controller.addVoiceErrorText.value != null
                                  ? AppColors.red500
                                  : null,
                            ),
                            isLoading: controller.isLoading.value,
                            errorText: controller.addVoiceErrorText.value,
                            onAdd: () {
                              controller
                                  .addVoice(controller.addVoiceController.text)
                                  .then((isOk) {
                                if (isOk) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                          ),
                        ));
                  },
                );
                controller.initData();
              },
              icon: const Icon(
                Icons.add,
              ),
            )
          ],
        ),
        body: _body(context));
  }
}
