import 'package:chorale_fva/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../framework/widgets/add_bottomsheet.dart';
import '../../../../framework/widgets/no_data.dart';
import '../../data/models/role.dart';
import '../controllers/roles_controller.dart';
import '../controllers/voices_binding.dart';


class RolesScreen extends GetView<RolesController> {
  const RolesScreen({super.key});

  Widget _body() {
    return Obx(() {
      bool isDataEmpty = controller.rolesFields.value == null ||
          controller.rolesFields.value!.docs.isEmpty;

      if (controller.isLoading.value) {
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
            itemCount: controller.rolesFields.value!.docs.length,
            itemBuilder: (context, index) {
              var doc = controller.rolesFields.value!.docs[index];
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
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                backgroundColor: AppColors.backgroundColor,
                                isScrollControlled: true,
                                builder: (_) {
                                  controller.editRoleController.text =
                                      (doc.data() as Map)['name'];
                                  return FractionallySizedBox(
                                      heightFactor: 0.7,
                                      widthFactor: 0.95,
                                      child: AddBottomsheet(
                                        title: 'Modifier une responsabilité : ',
                                        controller:
                                            controller.editRoleController,
                                        buttonTitle: 'Modifier',
                                        onAdd: () {
                                          controller
                                              .updateRole(Role(
                                                  id: (doc.data() as Map)['id'],
                                                  name: controller
                                                      .editRoleController
                                                      .text))
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
                                  .deleteRole((doc.data() as Map)['id']);
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
    RolesBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Responsabilité'),
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
                        child: AddBottomsheet(
                          title: 'Ajouter une responsabilité : ',
                          controller: controller.addRoleController,
                          buttonTitle: 'Ajouter',
                          onAdd: () {
                            controller
                                .addRole(controller.addRoleController.text)
                                .then((_) {
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
