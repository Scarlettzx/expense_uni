import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageViewDialog extends StatelessWidget {
  final String imageUrl;

  const ImageViewDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder<ui.Image>(
        future: _getImageSize(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final image = snapshot.data!;
          Size screenSize = MediaQuery.of(context).size;
          return Container(
            width: screenSize.width >= image.width.toDouble()
                ? image.width.toDouble()
                : double.infinity,
            height: screenSize.height >= image.height.toDouble()
                ? image.height.toDouble()
                : double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: (screenSize.width >= image.width.toDouble() &&
                        screenSize.height >= image.height.toDouble())
                    ? BoxFit.cover
                    : BoxFit.contain,
              ),
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }

  Future<ui.Image> _getImageSize(String imageUrl) async {
    final NetworkImage networkImage = NetworkImage(imageUrl);
    final ImageStream stream = networkImage.resolve(ImageConfiguration.empty);
    final Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;
    listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final image = info.image;
        completer.complete(image);
        stream.removeListener(listener);
      },
      onError: (Object exception, StackTrace? stackTrace) {
        completer.completeError(exception, stackTrace);
        stream.removeListener(listener);
      },
    );
    stream.addListener(listener);
    return completer.future;
  }
}
