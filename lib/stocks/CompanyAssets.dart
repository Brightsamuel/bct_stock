import 'package:flutter/material.dart';
//import 'package:mon/company.dart';
import 'package:mon/stocks/Company.dart';
//import 'package:mon/stocks/CompanyAssets.dart';




class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Screen'),
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
