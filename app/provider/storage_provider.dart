import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:openqrx/app/util/print.dart';

class StorageProvider extends ChangeNotifier {
  static StorageProvider? _instance;
  StorageProvider._();
  static StorageProvider get instance {
    _instance ??= StorageProvider._();
    return _instance!;
  }

  Map<String?, double> map = {};

  Future<String> uploadFile(String filePath, String storagePath,
      {int? thumbSize}) async {
    final storageRef = FirebaseStorage.instance.ref();
    final filename = path.basename(filePath);
    final fileRef = storageRef.child('$storagePath/$filename');
    map[filename] = 0;
    notifyListeners();

    // Upload the file and track progress
    final thumb = await generateThumb(filePath, thumbSize);
    final uploadTask = fileRef.putFile(thumb);
    // final uploadTask = fileRef.putFile(File(filePath));
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      final progress = snapshot.bytesTransferred / snapshot.totalBytes;
      xPrint('Progress: ${progress * 100}%');
      map[filename] = progress;
      notifyListeners();
    });
    // Wait for upload to finish and get URL
    await uploadTask.whenComplete(() => null);
    final downloadUrl = await fileRef.getDownloadURL();
    return downloadUrl; // Update media with URL
  }

  Future<File> generateThumb(String filePath, int? thumbSize) async {
    thumbSize ??= 160;
    File imageFile = File(filePath);
    Uint8List imageBytes = await imageFile.readAsBytes();
    Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: thumbSize,
      minWidth: thumbSize,
      quality: 80,
    );
    Directory tempDir = await getTemporaryDirectory();
    String thumbnailName = 'thumb_${path.basename(filePath)}';
    String thumbnailPath = path.join(tempDir.path, thumbnailName);
    File thumbnailFile = File(thumbnailPath);
    await thumbnailFile.writeAsBytes(compressedBytes);
    return thumbnailFile;
  }

  Future<void> delete(String url) async {
    final storageRef = FirebaseStorage.instance.refFromURL(url);
    await storageRef.delete();
  }
}
