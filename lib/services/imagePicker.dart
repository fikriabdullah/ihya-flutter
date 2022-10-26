import 'package:image_picker/image_picker.dart';
class imagePicker{
  final ImagePicker _picker = ImagePicker();
  XFile? photoForum = XFile("");
  Future imagePick()async{
    photoForum = await _picker.pickImage(source: ImageSource.gallery)
        .whenComplete(() => photoForum!.path);
    print("photo pick: ${photoForum!.path}");
  }

}