import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  final CollectionReference itemRef =
      FirebaseFirestore.instance.collection('Items');
  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference toppingRef =
      FirebaseFirestore.instance.collection('Toppings');
  final CollectionReference sizeRef =
      FirebaseFirestore.instance.collection('Size');
  final CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('Category');
  Stream<QuerySnapshot> queryProduct() {
    return productRef.snapshots();
  }

  Stream<QuerySnapshot> queryTopping() {
    return toppingRef.snapshots();
  }

  Stream<QuerySnapshot> querySize() {
    return sizeRef.snapshots();
  }

  Stream<QuerySnapshot> queryItem() {
    return itemRef.snapshots();
  }

  Stream<QuerySnapshot> queryCategory() {
    return categoryRef.orderBy('stt').snapshots();
  }
}
