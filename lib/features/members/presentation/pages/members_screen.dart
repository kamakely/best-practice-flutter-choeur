import 'package:chorale_fva/features/members/presentation/widgets/add_member_form.dart';
import 'package:chorale_fva/framework/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/members_binding.dart';
import '../controllers/members_controller.dart';

class MembersScreen extends GetView<MembersController> {
  const MembersScreen({super.key});

  Widget _body(
    BuildContext context,
  ) {
    return Obx(() {
      bool isDataEmpty = controller.membersFields.value == null ||
          controller.membersFields.value!.docs.isEmpty;

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
            itemCount: controller.membersFields.value!.docs.length,
            itemBuilder: (context, index) {
              var doc = controller.membersFields.value!.docs[index];
              return GestureDetector(
                onTap: () {},
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0.w,
                    vertical: 16.0.h,
                  ),
                  child: Row(
                    children: [
                      (doc.data() as Map)['profil_url'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(300.r),
                              child: Image.network(
                                (doc.data() as Map)['profil_url'],
                                width: 100.h,
                                height: 100.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox(
                              width: 100.h,
                              height: 100.h,
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.person_2_rounded,
                                  size: 60.h,
                                ),
                              ),
                            ),
                      Gap(20.w),
                      Expanded(
                        child: Text(
                          '${(doc.data() as Map)['first_name']} ${(doc.data() as Map)['last_name']}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                )),
              );
            }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MembersBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Membre',
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
        body: _body(context));
  }
}
