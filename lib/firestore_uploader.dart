// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dummy_data1.dart';
//
// class FirestoreUploader {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> uploadDummyData() async {
//     WriteBatch batch = _firestore.batch();
//
//     // FOOD_MANAGEMENT 데이터 업로드
//     List<Map<String, dynamic>> foodManagementData = DummyData.getFoodManagementData();
//     for (var food in foodManagementData) {
//       DocumentReference docRef = _firestore.collection('FOOD_MANAGEMENT').doc();
//       batch.set(docRef, food);
//     }
//
//     // FOOD_MANAGEMENT_LOG 데이터 업로드
//     List<Map<String, dynamic>> foodManagementLogData = DummyData.getFoodManagementLogData();
//     for (var log in foodManagementLogData) {
//       DocumentReference docRef = _firestore.collection('FOOD_MANAGEMENT_LOG').doc();
//       batch.set(docRef, log);
//     }
//
//     // Batch commit
//     try {
//       await batch.commit();
//       print("Data uploaded successfully!");
//     } catch (e) {
//       print("Error uploading data: $e");
//     }
//   }
// }
