import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider = Provider(
  (ref) => FirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  FirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> uploadImage(
    String imageName,
    Uint8List data,
    String mime,
  ) async {
    UploadTask uploadTask =
        firebaseStorage.ref().child('images/$imageName').putData(
            data,
            SettableMetadata(
              contentType: mime,
            ));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
