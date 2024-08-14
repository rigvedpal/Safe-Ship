import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(String name, double price, String category) {
    return productsCollection.add({
      'name': name,
      'price': price,
      'category': category,
    });
  }

  Future<void> updateProduct(String id, String name, double price, String category) {
    return productsCollection.doc(id).update({
      'name': name,
      'price': price,
      'category': category,
    });
  }

  Future<void> deleteProduct(String id) {
    return productsCollection.doc(id).delete();
  }

  Stream<QuerySnapshot> getProducts() {
    return productsCollection.snapshots();
  }
}