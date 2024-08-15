import 'package:flutter/material.dart';

class PresenceScreen extends StatelessWidget {
  const PresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Présence'),
          backgroundColor: const Color(0xFF62D9F7),
          
        ),
      body: const Center(child: Text('Présence'),));
  }
}