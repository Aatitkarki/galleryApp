import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/features/gallery/model/image_model.dart';
import 'package:gallery_app/features/gallery/repository/firebase_database_repository.dart';
import 'package:gallery_app/features/gallery/repository/firebase_storage_repository.dart';

final galleryViewProvider = ChangeNotifierProvider((ref) => GalleryViewModel(
    ref.read(firebaseStorageRepositoryProvider),
    ref.read(firebaseDatabaseRepositoryProvider)));

class GalleryViewModel extends ChangeNotifier {
  final FirebaseDatabaseRepository firebaseDatabaseRepository;
  final FirebaseStorageRepository firebaseStorageRepository;

  List<ImageModel> _images = [];

  bool _isLoading = false;
  bool _isInitial = true;
  bool get isLoading => _isLoading;
  bool get isInitial => _isInitial;

  List<ImageModel> get images => _images;

  GalleryViewModel(
      this.firebaseStorageRepository, this.firebaseDatabaseRepository);

  loadImages() async {
    _isLoading = true;
    _isInitial = false;
    notifyListeners();
    await firebaseDatabaseRepository
        .getAllImageData()
        .then((value) => _images = value)
        .whenComplete(onLoadingComplete);
  }

  onLoadingComplete() {
    _isLoading = false;
    notifyListeners();
  }

  Future<String> uploadImage(
      String imageName, Uint8List imageData, String mime) async {
    String data =
        await firebaseStorageRepository.uploadImage(imageName, imageData, mime);
    await firebaseDatabaseRepository
        .addNewImageData(ImageModel(imageUrl: data));
    _images.add(ImageModel(imageUrl: data));
    notifyListeners();
    return data;
  }
}
