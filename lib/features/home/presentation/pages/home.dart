import 'package:chorale_fva/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  Home({super.key});

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Azela'),
          backgroundColor: const Color(0xFF62D9F7),
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
