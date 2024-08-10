import 'package:chorale_fva/features/members/presentation/widgets/add_member_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/members_binding.dart';
import '../controllers/members_controller.dart';

class MembersScreen extends GetView<MembersController> {
  const MembersScreen({super.key});

  Widget _body() {
    return Obx(() {
      bool isDataEmpty = controller.membersFields.value == null ||
          controller.membersFields.value!.docs.isEmpty;

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
            itemCount: controller.membersFields.value!.docs.length,
            itemBuilder: (context, index) {
              var doc = controller.membersFields.value!.docs[index];
              return Card(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0.w,
                  vertical: 16.0.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${(doc.data() as Map)['first_name']} ${(doc.data() as Map)['last_name']}'),
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              ));
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MembersBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Membre'),
          backgroundColor: const Color(0xFF62D9F7),
          actions: [
            IconButton(
              onPressed: () async {
                await controller.getVoices();
                await Get.to(
                    () => AddMemberForm(
                          controller: controller,
                        ),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 300));
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
