import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:open_file/open_file.dart';
import 'package:uni_expense/src/components/motion_toast.dart';

class FilePickerComponent extends StatefulWidget {
  final void Function(PlatformFile?) onFileSelected;

  const FilePickerComponent({Key? key, required this.onFileSelected})
      : super(key: key);
  @override
  State<FilePickerComponent> createState() => _FilePickerComponentState();
}

class _FilePickerComponentState extends State<FilePickerComponent> {
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'แนบไฟล์เอกสาร',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'ไฟล์ *.jpeg, *.jpg, *.png, *.pdf จำนวน 1 ไฟล์ \n( ขนาดไม่เกิน 500 KB )',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
        ),
        SizedBox(
          height: MediaQuery.of(context).devicePixelRatio * 10,
        ),
        (file == null)
            ? buildFilePickerPlaceholder(context)
            : buildSelectedFile(context),
      ],
    );
  }

  Widget buildFilePickerPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(255, 234, 239, 0.29),
      ),
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/img_expense_pick.png",
            fit: BoxFit.fill,
          ),
          Text('อัพโหลดไฟล์ที่นี่'),
          SizedBox(
            height: MediaQuery.of(context).devicePixelRatio * 3,
          ),
          ClipOval(
            child: Material(
              color: Color(0xffff99ca),
              child: InkWell(
                splashColor: Color(0xffff99ca),
                onTap: () {
                  pickFiles(context);
                },
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(IconaMoon.share2, color: Colors.white)),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget buildSelectedFile(BuildContext context) {
    return InkWell(
      onTap: () {
        viewFile(file!);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(255, 234, 239, 0.29),
        ),
        width: double.infinity,
        child: ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: Text(file!.name.toString()),
          trailing: InkWell(
            onTap: () {
              setState(() {
                file = null;
                widget.onFileSelected(null);
              });
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  void pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;

    PlatformFile pickedFile = result.files.first;

    if (pickedFile.size > 500 * 1024) {
      // Handle file size exceeds 500 KB
      print("File size exceeds 500 KB");
      return CustomMotionToast.show(
        context: context,
        title: "File Error",
        description: "File size exceeds 500 KB",
        icon: Icons.notification_important,
        primaryColor: Colors.pink,
        width: 300,
        height: 100,
        animationType: AnimationType.fromLeft,
        fontSizeTitle: 18.0,
        fontSizeDescription: 15.0,
      );
    }

    // Call the callback function with the selected file
    widget.onFileSelected(pickedFile);

    setState(() {
      file = pickedFile;
    });
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
