import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? selectedStore;
  final List<Stock> stockList = []; // List to store the stock items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 37, 33, 243),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 34.0,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 33, 243),
        title: Center(
          child: Text(
            "Stocks",
            style: GoogleFonts.poppins(
              fontSize: 40.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Store:", style: GoogleFonts.poppins()),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedStore,
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      selectedStore = value;
                    });
                  },
                  hint: const Text("Select Store"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: stockList.isEmpty
                  ? const Center(child: Text("No stock available."))
                  : ListView.builder(
                      itemCount: stockList.length,
                      itemBuilder: (context, index) {
                        final stock = stockList[index];
                        if (selectedStore == null ||
                            stock.store == selectedStore) {
                          return Card(
                            child: ListTile(
                              title: Text(stock.name),
                              subtitle: Text(
                                'Units: ${stock.units} | Unit Price: ${stock.unitPrice} UGX',
                              ),
                              trailing: Text(
                                'Total: ${stock.totalPrice.toStringAsFixed(2)} UGX',
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStockDialog(context), // Show the dialog
        child: const Icon(Icons.add),
      ),
    );
  }

  List<DropdownMenuItem<String>> get items {
    return [
      const DropdownMenuItem(value: "Store 1", child: Text("Store 1")),
      const DropdownMenuItem(value: "Store 2", child: Text("Store 2")),
      const DropdownMenuItem(value: "Store 3", child: Text("Store 3")),
      const DropdownMenuItem(value: "Store 4", child: Text("Store 4")),
      const DropdownMenuItem(value: "Store 5", child: Text("Store 5")),
    ];
  }

  void _showAddStockDialog(BuildContext context) {
    final nameController = TextEditingController();
    final unitsController = TextEditingController();
    final unitPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Stock'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Stock Name'),
              ),
              TextField(
                controller: unitsController,
                decoration: const InputDecoration(labelText: 'Units'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: unitPriceController,
                decoration: const InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final units = int.tryParse(unitsController.text) ?? 0;
                final unitPrice =
                    double.tryParse(unitPriceController.text) ?? 0.0;

                if (name.isNotEmpty && units > 0 && unitPrice > 0) {
                  if (selectedStore != null) {
                    _addStock(name, units, unitPrice, selectedStore!);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a store')),
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addStock(String name, int units, double unitPrice, String store) {
    final stock = Stock(
      name: name,
      units: units,
      unitPrice: unitPrice,
      store: store,
    );

    setState(() {
      stockList.add(stock); // Add stock to the list
    });
  }
}

class Stock {
  final String name;
  final int units;
  final double unitPrice;
  final String store;

  Stock({
    required this.name,
    required this.units,
    required this.unitPrice,
    required this.store,
  });

  double get totalPrice => units * unitPrice;
}
