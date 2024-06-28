import 'package:chorale_fva/features/home/presentation/controllers/home_binding.dart';
import 'package:chorale_fva/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final List<String> menu = [
    'Membres',
    'Présences',
    'Voix',
    'évenements',
    'Responsabilités',
    'Chansons',
  ];

  @override
  Widget build(BuildContext context) {
    HomeBinding().dependencies();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Azela'),
          backgroundColor: const Color(0xFF62D9F7),
          actions: [
            IconButton(
              onPressed: () async {
                await controller.logout();
              },
              icon: const Icon(
                Icons.logout_outlined,
              ),
            ),
            Gap(10.w),
          ],
        ),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: menu.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Center(child: Text(menu[index])),
                );
              }),
        ));
  }
}
