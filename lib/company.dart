import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon/store.dart';


class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 33, 243),
        title: const Text('Company Screen',
                style: TextStyle(
                  color: Colors.white,                  
                ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrentAssetsScreen()),
                );
              },
              child: const Text('Current Assets'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FixedAssetsScreen()),
                );
              },
              child: const Text('Fixed Assets'),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentAssetsScreen extends StatelessWidget {
  const CurrentAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Assets'),
      ),
      body: const StockScreen(assetType: 'Current Assets'),
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
      body: const StockScreen(assetType: 'Fixed Assets'),
    );
  }
}
