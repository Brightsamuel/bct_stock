import 'package:flutter/material.dart';


class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Clients Screen!'),
      ),
    );
  }
}
