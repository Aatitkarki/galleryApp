import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_app/core/di/injector.dart';
import 'package:gallery_app/core/extensions/extensions.dart';
import 'package:gallery_app/core/routes/app_router.dart';
import 'package:gallery_app/core/themes/app_colors.dart';
import 'package:gallery_app/core/themes/app_styles.dart';
import 'package:gallery_app/core/widgets/navbar_widget.dart';
import 'package:gallery_app/features/gallery/viewmodel/gallery_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/file_picker.dart';
import '../../../core/widgets/widgets.dart';

class GalleryView extends ConsumerStatefulWidget {
  const GalleryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GalleryViewState();
}

class _GalleryViewState extends ConsumerState<GalleryView> {
  XFile? image;
  String? imageUrl;
  Uint8List? imageData;
  String? imageName;
  String? mime;
  bool isUploading = false;

  late DropzoneViewController controller;
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(galleryViewProvider).loadImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final galleryProvider = ref.watch(galleryViewProvider);

    return BaseScaffoldWidget(
      title: 'My Gallery App',
      navItems: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: CustomButton(
            onPressed: () {
              clearInitialData();
              _showDialog(context);
            },
            label: 'Upload Image',
          ),
        )
      ],
      body: galleryProvider.isLoading
          ? const CircularProgressIndicator.adaptive()
          : galleryProvider.images.isEmpty
              ? Container(
                  child: const Text(
                      "No images added yet, Try uploading some images!"),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    galleryProvider.loadImages();
                  },
                  child: MasonryGridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    addAutomaticKeepAlives: true,
                    mainAxisSpacing: 12,
                    itemCount: galleryProvider.images.length,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            galleryProvider.images[index].imageUrl),
                      );
                    },
                  ),
                ),
    );
  }

  _pickImage(BuildContext context, Function(void Function()) sts) async {
    if (!isUploading) {
      image = await FilePickerUtil.pickImage(
        context,
      );
      imageName = image!.name;
      imageData = await image?.readAsBytes();
      mime = image?.mimeType;
      if (image != null) imageUrl = image!.path;
      sts(() {});
    }
  }

  Future onFileDropped(dynamic event, Function(void Function()) sts) async {
    imageName = event.name;
    imageData = await controller.getFileData(event);
    imageUrl = await controller.createFileUrl(event);
    mime = await controller.getFileMIME(event);
    sts(() {
      isHovering = false;
    });
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
              builder: (context, setState) => buildWidget(context, setState)),
        );
      },
    );
  }

  buildWidget(BuildContext context, Function(void Function()) sts) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 800,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upload Image",
                style: AppStyles.text14PxBold.copyWith(color: AppColors.black),
              ),
              GestureDetector(
                onTap: () {
                  getIt<AppRouter>().pop();
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.fabRedBackground,
                child: Icon(Icons.image),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Images',
                    style: AppStyles.text14Px,
                  ),
                  const Text('PNG, JPG')
                ],
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Stack(
              children: [
                if (!isUploading)
                  DropzoneView(
                    operation: DragOperation.copy,
                    cursor: CursorType.grab,
                    onCreated: (DropzoneViewController ctrl) =>
                        controller = ctrl,
                    onLoaded: () {},
                    onError: (String? ev) => print('Error: $ev'),
                    onHover: () => sts(() {
                      isHovering = true;
                    }),
                    onDrop: (event) => onFileDropped(event, sts),
                    mime: const ['image/jpeg', 'image/png'],
                    onLeave: () => sts(() {
                      isHovering = false;
                    }),
                  ),
                Opacity(
                  opacity: isUploading ? 0.4 : 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 500,
                      width: double.infinity,
                      decoration: DottedDecoration(
                        AppColors.transparent,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shape: Shape.box,
                        color: isHovering
                            ? AppColors.statusGreen
                            : AppColors.textGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (imageUrl != null)
                            Image.network(
                              imageUrl!,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          if (imageUrl == null) ...[
                            const Icon(
                              Icons.file_upload_outlined,
                              size: 100,
                            ),
                            Text(
                              "Drag & Drop to Upload",
                              style: AppStyles.text12PxBold,
                            ),
                          ],
                          TextButton(
                              onPressed: () => _pickImage(context, sts),
                              child: Text(
                                imageUrl != null ? 'Change Image' : 'Or browse',
                                style: AppStyles.text12PxBold.copyWith(
                                    color: AppColors.fabRedBackground),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                if (isUploading)
                  const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator.adaptive())
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButton(
              label: 'Upload',
              fullWidth: false,
              onPressed: () async {
                if (!isUploading) {
                  sts(() {
                    isUploading = true;
                  });
                  if (imageData != null && imageName != null) {
                    await ref
                        .read(galleryViewProvider)
                        .uploadImage(imageName!, imageData!, mime!);
                    // getIt<AppRouter>().pop();
                    context.showSnackBar(
                        message: 'File Uploaded Successfully', error: false);
                    sts(() {
                      isUploading = false;
                    });
                  }
                } else {
                  context.showSnackBar(
                      message: 'Please wait till pervious file uploads',
                      error: true);
                }
              },
              backgroundColor:
                  imageUrl == null ? AppColors.textGrey : AppColors.statusGreen,
            ),
          )
        ],
      ),
    );
  }

  void clearInitialData() {
    image = null;
    imageData = null;
    mime = null;
    imageUrl = null;
  }
}
