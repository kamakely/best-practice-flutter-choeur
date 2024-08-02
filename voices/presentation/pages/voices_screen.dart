import 'package:flutter/material.dart';

class VoicesScreen extends StatelessWidget {
  const VoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Azela'),
          backgroundColor: const Color(0xFF62D9F7),
          
        ),
      body: const Center(child: Text('Voix'),));
  }
}