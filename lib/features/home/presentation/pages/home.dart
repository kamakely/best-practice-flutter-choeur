import 'package:chorale_fva/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Azela'),
          backgroundColor: const Color(0xFF62D9F7),
        ),
        body: const Center(
          child: Text('Home'),
        ));
  }
}
