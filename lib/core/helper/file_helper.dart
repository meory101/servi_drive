import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
/*nour othman*/

abstract class FileHelper {
  static Future<File?> getFile({List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions,
      type: allowedExtensions != null ? FileType.custom : FileType.any,
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      return file;
    }
    return null;
  }

  static String convertToBase64({required File? file}) {
    if (file == null) return "";
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static String convertToBase64WithHeader({required File? file}) {
    if (file == null) return "";

    List<int> imageBytes = file.readAsBytesSync();

    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';

    final base64String = base64Encode(imageBytes);

    return 'data:$mimeType;base64,$base64String';
  }

  static String getFileName({required File file}) {
    return path.basename(file.path);
  }

  static String getFileExtension({required String fileName}) {
    return path.extension(fileName).replaceAll('.', '');
  }

  static void downloadFile({
    required String url,
    Function(double)? onProgress,
    required BuildContext context,
  }) {
    if (url.isEmpty) return;
  }

  static String addHeaderToBase64(
      {required String base64Data, required String extension}) {
    String base64Header = 'data:image/$extension;base64,';
    return base64Header + base64Data;
  }

  static Future<List<File>?> getFiles(
      {List<String>? allowedExtensions, bool allowMultiple = false}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      allowedExtensions: allowedExtensions,
      type: allowedExtensions != null ? FileType.custom : FileType.any,
    );
    if (result != null) {
      return result.paths.whereType<String>().map((p) => File(p)).toList();
    }
    return null;
  }
}
