import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Aucune donnée',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
