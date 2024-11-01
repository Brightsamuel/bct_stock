import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: const Color.fromARGB(255, 37, 33, 243),
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
              //labelStyle: const TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.black), 
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 37, 33, 243),
            ),
            onPressed: () {
              final clientName = _clientControllers[i].text;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StocksScreen(clientName: clientName)),
              );
            },
                  child: Text('Client ${i + 1}',
                  style: const TextStyle(
                  color: Colors.white),
                  ),
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

class StocksScreen extends StatefulWidget {
  final String clientName;
  const StocksScreen({required this.clientName, super.key});

  @override
  _StocksScreenState createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  String? selectedStore;
  List<Stock> stockList = [];
  
  List<DropdownMenuItem<String>> get items {
    return const [
      DropdownMenuItem(value: "Stock in", child: Text("Stock in")),
      DropdownMenuItem(value: "Stock out", child: Text("Stock out")),
      // DropdownMenuItem(value: "Store 3", child: Text("Store 3")),
      // DropdownMenuItem(value: "Store 4", child: Text("Store 4")),
      // DropdownMenuItem(value: "Store 5", child: Text("Store 5")),
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
                final unitPrice = double.tryParse(unitPriceController.text) ?? 0.0;
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

  void _exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheet = excel[excel.getDefaultSheet()!];
    sheet.appendRow(['Ref no.', 'Store name', 'Item', 'Units', 'Quantity', 'Rate', 'Amount']);
    for (var stock in stockList) {
      sheet.appendRow([stock.name, stock.store, 'Item', stock.units.toString(), 'Quantity', stock.unitPrice.toString(), stock.totalPrice.toString()]);
    }
    var directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/stock_in.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.save()!);
    ShareExtend.share(filePath, "file");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 33, 243),
        //automaticallyImplyLeading: false,
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
                        if (selectedStore == null || stock.store == selectedStore) {
                          return Card(
                            child: ListTile(
                              title: Text(stock.name),
                              subtitle: Text('Units: ${stock.units} | Unit Price: ${stock.unitPrice} UGX'),
                              trailing: Text('Total: ${stock.totalPrice.toStringAsFixed(2)} UGX'),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _exportToExcel,
              child: const Text('Export'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStockDialog(context),
        child: const Icon(Icons.add),
      ),
    );
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
