import 'package:flutter/material.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/providers/firestore_service.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key, this.inventory, this.id});

  final Inventory? inventory;
  final String? id;

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late TextEditingController nameController;
  late TextEditingController deskripsiController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    deskripsiController = TextEditingController();

    if (widget.inventory != null) {
      nameController.text = widget.inventory!.name;
      deskripsiController.text = widget.inventory!.description;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Page'),
        actions: [
          IconButton(
              onPressed: () async {
                if (widget.inventory != null) {
                  await FirestoreService.editInventory(
                    Inventory(
                        name: nameController.text,
                        description: deskripsiController.text),
                    widget.id!,
                  );
                } else {
                  await FirestoreService.addInventory(
                    Inventory(
                        name: nameController.text,
                        description: deskripsiController.text),
                  );
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Masukkan nama barang',
                label: Text('Nama Barang'),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: deskripsiController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Masukkan deskripsi barang',
                label: Text('Deskripsi Barang'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
