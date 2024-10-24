
import 'package:flutter/material.dart';

class CurrentAssetsScreen extends StatelessWidget {
  const CurrentAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Assets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Details of Current Assets'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrentAssetsStockInScreen()),
                );
              },
              child: const Text('Stock In'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrentAssetsStockOutScreen()),
                );
              },
              child: const Text('Stock Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class FixedAssetsScreen extends StatelessWidget {
  const FixedAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixed Assets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Details of Fixed Assets'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FixedAssetsStockInScreen()),
                );
              },
              child: const Text('Stock In'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FixedAssetsStockOutScreen()),
                );
              },
              child: const Text('Stock Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentAssetsStockInScreen extends StatelessWidget {
  const CurrentAssetsStockInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Assets Stock In'),
      ),
      body: const Center(
        child: Text('Stock In details specific to Current Assets'),
      ),
    );
  }
}

class CurrentAssetsStockOutScreen extends StatelessWidget {
  const CurrentAssetsStockOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Assets Stock Out'),
      ),
      body: const Center(
        child: Text('Stock Out details specific to Current Assets'),
      ),
    );
  }
}

class FixedAssetsStockInScreen extends StatelessWidget {
  const FixedAssetsStockInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixed Assets Stock In'),
      ),
      body: const Center(
        child: Text('Stock In details specific to Fixed Assets'),
      ),
    );
  }
}

class FixedAssetsStockOutScreen extends StatelessWidget {
  const FixedAssetsStockOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixed Assets Stock Out'),
      ),
      body: const Center(
        child: Text('Stock Out details specific to Fixed Assets'),
      ),
    );
  }
}
