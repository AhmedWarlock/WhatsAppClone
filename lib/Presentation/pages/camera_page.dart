import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_clone/injection_container.dart';

class CameraPage extends StatefulWidget {
  final CameraController cameraController;
  const CameraPage({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.cameraController != null &&
        widget.cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: CameraPreview(widget.cameraController),
            ),
            _cameraButtonsWidget(),
            _galleryWidget(context),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            _cameraButtonsWidget(),
            _galleryWidget(context),
          ],
        ),
      );
    }
  }

  Widget _cameraButtonsWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.flash_off_rounded,
              color: Colors.black,
              size: 40,
            ),
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            Icon(
              Icons.cameraswitch_rounded,
              color: Colors.black,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _galleryWidget(context) {
    return Positioned(
        bottom: 130,
        child: Container(
          width: 400,
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 100,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black38, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.2, 0.2),
                            spreadRadius: 0.4,
                            color: Colors.black.withOpacity(0.2)),
                      ]),
                );
              }),
        ));
  }

  // Future<void> getGalleryPhotos() async {
  //   await CustomPicker.CustomImagePicker().getAllImages(callback: (value) {
  //     _galleryPhotos = value;
  //   });
  // }
}
