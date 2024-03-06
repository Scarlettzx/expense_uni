import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';

import 'imagepicker.dart';
import 'imageviewdialog.dart';

class ImagePickerAndViewer extends StatelessWidget {
  final bool checkdohaveimg;
  final FileUrl? showimg;
  final Function(PlatformFile)? onFileSelected;
  final PlatformFile? selectedFile;
  final Function(bool)? onTapcheckdohaveimg;

  const ImagePickerAndViewer({
    Key? key,
    required this.checkdohaveimg,
    this.showimg,
    this.onTapcheckdohaveimg,
    this.onFileSelected,
    this.selectedFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("checkdohaveimg");
    // print(checkdohaveimg);
    // print("showimg");
    // print(showimg);
    return checkdohaveimg == false
        ? ImagePickerComponent(onFileSelected: onFileSelected)
        : (showimg != null)
            ? InkWell(
                onTap: () async {
                  // final networkImage = NetworkImage(showimg!.url!);
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return ImageViewDialog(imageUrl: showimg!.url!);
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 234, 239, 0.29),
                  ),
                  width: double.infinity,
                  child: ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    title: Text(showimg!.path.toString()),
                    trailing: InkWell(
                      onTap: () {
                        onTapcheckdohaveimg?.call(false);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(); // สำหรับกรณีที่ checkdohaveimg เป็น true แต่ showimg ไม่มีค่า
  }
}
