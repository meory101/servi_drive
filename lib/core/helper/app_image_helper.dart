import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../resource/color_manager.dart';


abstract class AppImageHelper {
  static Future<File?>? pickImageFrom({required ImageSource source}) async {
    File? tempImage;
    try {
      final photo = await ImagePicker().pickImage(
        source: source,
        maxHeight: 600,
        maxWidth: 600,
        imageQuality: 85,
      );
      if (photo == null) return null;
      tempImage = File(photo.path);

      File? croppedImage = await _cropImage(imageFile: tempImage);
      tempImage = croppedImage ?? tempImage;
    } catch (error) {
    }
    return tempImage;
  }

  static Future<List<File?>?>? pickMultiImagesFrom() async {
    List<File>? finalImages = [];
    try {
      List<XFile?>? photos = await ImagePicker().pickMultiImage(
        maxHeight: 600,
        maxWidth: 600,
        imageQuality: 85,
      );

      if (photos.isEmpty) return null;

      for (XFile? photo in photos) {
        if ((photo?.path ?? "").isNotEmpty) {
          try {
            File? croppedFile = await _cropImage(imageFile: File(photo!.path));
            if (croppedFile != null) {
              finalImages.add(croppedFile);
            } else {
              finalImages.add(File(photo.path));
            }
          } catch (e) {
            if (photo != null) {
              finalImages.add(File(photo.path));
            }
          }
        }
      }

      return finalImages;
    } catch (error) {
      return null;
    }
  }

  static String convertBase46Encoder({required File image}) {
    List<int> imageBytes = image.readAsBytesSync() ;
    return base64Encode(imageBytes);
  }

  static Image convertBase46Decoder({required String image}) {
    return Image.memory(const Base64Decoder().convert(image));
  }

  static Future<File?> _cropImage({required File imageFile}) async {
    try {
      if (!await imageFile.exists()) {
        return null;
      }

      CroppedFile? croppedImg = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 85,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: AppColorManager.mainColor,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: AppColorManager.mainColor,
            cropFrameColor: AppColorManager.mainColor,
            lockAspectRatio: true,
            hideBottomControls: false,
            cropGridColumnCount: 3,
            cropGridRowCount: 3,
          ),
          IOSUiSettings(
            title: '',
            doneButtonTitle: 'Done',
            cancelButtonTitle: 'Cancel',
            rotateButtonsHidden: false,
            rotateClockwiseButtonHidden: false,
            aspectRatioLockEnabled: true,
            hidesNavigationBar: false,
          ),
        ],
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (croppedImg == null) {
        return null;
      }
      File croppedFile = File(croppedImg.path);
      if (await croppedFile.exists()) {
        return croppedFile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

