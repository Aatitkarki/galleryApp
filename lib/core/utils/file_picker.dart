import 'package:flutter/widgets.dart';
import 'package:gallery_app/core/extensions/extensions.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerUtil {
  static Future<XFile?> pickImage(BuildContext context) async {
    final ImagePicker imagePickerPlugin = ImagePicker();
    XFile? pickedFile;
    try {
      pickedFile =
          await imagePickerPlugin.pickImage(source: ImageSource.gallery);
    } catch (e) {
      context.showSnackBar(message: 'Unable to pick file', error: true);
    }
    return pickedFile;
  }
}
