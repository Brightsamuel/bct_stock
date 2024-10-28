import 'package:flutter/material.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientInputScreen()),
                );
              },
              child: const Text('clients'),
            ),
          ],
        ),
      ),
    );
  }
}

class ClientInputScreen extends StatefulWidget {
  const ClientInputScreen({super.key});

  @override
  _ClientInputScreenState createState() => _ClientInputScreenState();
}

class _ClientInputScreenState extends State<ClientInputScreen> {
  final List<TextEditingController> _clientControllers = [];

  void _addClient() {
    setState(() {
      _clientControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (var controller in _clientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addClient,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (var i = 0; i < _clientControllers.length; i++) ...[
                TextField(
                  controller: _clientControllers[i],
                  decoration: InputDecoration(
                    labelText: 'Client ${i + 1}',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final clientName = _clientControllers[i].text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StocksScreen(clientName: clientName)),
                    );
                  },
                  child: Text('Go to Stocks Screen for Client ${i + 1}'),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class StocksScreen extends StatelessWidget {
  final String clientName;
  const StocksScreen({required this.clientName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks for $clientName'),
      ),
      body: Center(
        child: Text('Stocks screen for $clientName'),
      ),
    );
  }
}
