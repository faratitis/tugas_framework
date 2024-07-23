import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/models/inventory.dart';
import 'package:inventory_app/providers/firestore_service.dart';
import 'package:inventory_app/views/inventory_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inventory App'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const InventoryPage();
              },
            ));
          },
          child: (const Icon(Icons.add)),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:
              FirebaseFirestore.instance.collection('inventories').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var inventories = snapshot.data!.docs
                  .map((inventory) => Inventory.fromSnapshot(inventory))
                  .toList();
              return ListView.builder(
                itemCount: inventories.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data!.docs[index].id;
                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return InventoryPage(
                            inventory: inventories[index],
                            id: id,
                          );
                        },
                      ));
                    },
                    title: Text(
                      inventories[index].name,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      inventories[index].description,
                      maxLines: 2,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          FirestoreService.deleteInventory(id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

// Column(
//           children: [
//            
//           ],
//         )