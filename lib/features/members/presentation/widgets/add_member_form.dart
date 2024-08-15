import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../framework/widgets/dropdown_widget.dart';
import '../../../voices/data/models/voice.dart';
import '../controllers/members_controller.dart';

class AddMemberForm extends StatelessWidget {
  const AddMemberForm({
    super.key,
    this.readOnly = false,
    required this.controller,
  });

  final MembersController controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final textFieldWidth = Get.width * 0.8;

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Ajout d\'un Membre'),
          backgroundColor: const Color(0xFF62D9F7),
        ),
        body: Obx(
          () => controller.isGettingVoices.value
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap(40.h),
                        InkWell(
                          borderRadius: BorderRadius.circular(300.r),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              backgroundColor: AppColors.backgroundColor,
                              isScrollControlled: true,
                              builder: (_) {
                                return FractionallySizedBox(
                                    heightFactor: 0.7,
                                    widthFactor: 0.95,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await controller.imgFromGallery();
                                            },
                                            child: const Text(
                                                'Importer une image'),
                                          ),
                                          Gap(40.h),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await controller.imgFromCamera();
                                            },
                                            child:
                                                const Text('Prendre une photo'),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              controller.photo.value != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(300.r),
                                      child: Image.file(
                                        controller.photo.value!,
                                        width: 200.h,
                                        height: 200.h,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 200.h,
                                      height: 200.h,
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.person_2_rounded,
                                          size: 100.h,
                                        ),
                                      ),
                                    ),
                              Positioned(
                                  bottom: 10.h,
                                  right: 10.h,
                                  child: Container(
                                    padding: EdgeInsets.all(4.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.gray200,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: const Icon(Icons.edit),
                                  ))
                            ],
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.lastNameController,
                            decoration: InputDecoration(
                              label: Text(
                                'Nom',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.firstNameController,
                            decoration: InputDecoration(
                                label: Text(
                              'Prénom',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.phoneController,
                            decoration: InputDecoration(
                                label: Text(
                              'N° de téléphone',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                                label: Text(
                              'Email',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.addressController,
                            decoration: InputDecoration(
                                label: Text(
                              'Adresse',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.churchController,
                            decoration: InputDecoration(
                                label: Text(
                              'Eglise',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.groupController,
                            decoration: InputDecoration(
                                label: Text(
                              'Groupe',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: TextField(
                            controller: controller.remarkController,
                            decoration: InputDecoration(
                                label: Text(
                              'Remarque',
                              style: Theme.of(context).textTheme.labelMedium,
                            )),
                          ),
                        ),
                        Gap(40.h),
                        DropdownWidget<Voice>(
                          hintText: 'Sélectionner une voix',
                          width: textFieldWidth,
                          currentItem: controller.voiceValue.value,
                          items: controller.voices,
                          itemCallBack: (value) async {
                            if (value != null) {
                              controller.handleChangeVoiceValue(value);
                            }
                          },
                        ),
                        Gap(40.h),
                        SizedBox(
                          width: textFieldWidth,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addMember().then((_) {
                                Navigator.of(context).pop();
                                controller.clearForms();
                              });
                            },
                            child: const Text('Ajouter'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
