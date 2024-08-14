import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:safe_ship/providers/cart_provider.dart';

class ProductCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<DocumentSnapshot> products = snapshot.data.docs;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            DocumentSnapshot product = products[index];
            return ListTile(
              title: Text(product['name']),
              subtitle: Text('\$${product['price']}'),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addItem(
                    product.id,
                    product['name'],
                    product['price'],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added to cart')),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}