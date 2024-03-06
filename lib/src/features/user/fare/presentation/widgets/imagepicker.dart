import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../components/filepicker.dart';

class ImagePickerComponent extends StatelessWidget {
  final Function(PlatformFile)? onFileSelected;

  const ImagePickerComponent({Key? key, this.onFileSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilePickerComponent(
      onFileSelected: (file) {
        if (onFileSelected != null) {
          onFileSelected!(file!);
        }
      },
    );
  }
}
