import 'package:crud_penyewaan/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<UsersModel?> getusersById(String id) async {
    final doc = await usersRef.doc(id).get();
    if (doc.exists) {
      return UsersModel.fromFirestore(doc);
    }
    return null;
  }
}
