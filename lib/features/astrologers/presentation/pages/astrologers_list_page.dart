import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AstrologersListPage extends ConsumerWidget {
  const AstrologersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astrologers'),
      ),
      body: const Center(
        child: Text('Astrologers List Page'),
      ),
    );
  }
}

