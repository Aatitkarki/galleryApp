import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/features/gallery/model/image_model.dart';

final firebaseDatabaseRepositoryProvider = Provider(
  (ref) => FirebaseDatabaseRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class FirebaseDatabaseRepository {
  final FirebaseFirestore firestore;
  FirebaseDatabaseRepository({
    required this.firestore,
  });

  Future addNewImageData(ImageModel imageModel) async {
    final CollectionReference mainCollection = firestore.collection('images');
    await mainCollection.doc().set(imageModel.toJson());
  }

  Future<List<ImageModel>> getAllImageData() async {
    final CollectionReference mainCollection = firestore.collection('images');
    QuerySnapshot data = await mainCollection.get();
    List<ImageModel> imagesList = [];

    for (var d in data.docs) {
      Map<String, dynamic> singleData = d.data() as Map<String, dynamic>;
      if (singleData.isNotEmpty) {
        imagesList.add(ImageModel.fromJson(singleData));
      }
    }
    print(imagesList);
    return imagesList;
  }
}
