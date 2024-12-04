import 'package:image_picker/image_picker.dart';

class PickImage {
  static void single(
      {required Function(String?) onDone, bool gallery = true}) async {
    final file = await ImagePicker().pickImage(
      source: gallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 40,
    );
    onDone(file?.path);
  }

  static void multiple({required Function(List<String>?) onDone}) async {
    final List<XFile> file = await ImagePicker().pickMultiImage(
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 40,
    );
    onDone(file.map((e) => e.path).toList());
  }

  // wechat({required Function(String?) onDone, bool gallery = true}) async {
  //   final file = await ImagePicker().pickImage(
  //     source: ImageSource.values.last,
  //     imageQuality: 40,
  //   );
  //   onDone(file?.path);
  // }

  static void singleVideo(
      {required Function(String?) onDone, bool gallery = true}) async {
    final file = await ImagePicker().pickVideo(
      source: gallery ? ImageSource.gallery : ImageSource.gallery,
    );
    onDone(file?.path);
  }
}
