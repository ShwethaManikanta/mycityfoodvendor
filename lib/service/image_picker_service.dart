import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  //Return a [File] object pointing to the image that was picked.
  Future<PickedFile> pickImage({required ImageSource source}) async {
    final xFileSource = await ImagePicker().pickImage(
        source: source, maxHeight: 200, maxWidth: 200, imageQuality: 60);
    return PickedFile(xFileSource!.path);
  }

  Future<File?> chooseImageFile(BuildContext context) async {
    try {
      return await showModalBottomSheet(
          context: context, builder: (builder) => bottomSheet(context));
    } catch (e) {
      print(
          "The error is on line 23 image picker service ......" + e.toString());
    }
    return File('');
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose Image File",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20, width: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.account_circle_rounded,
                        size: 22,
                      ),
                      onPressed: () async {
                        final file =
                            await pickImage(source: ImageSource.camera);

                        File selected = File(
                          file.path,
                        );
                        if (await selected.exists()) {
                          Navigator.pop(context, selected);
                        } else {
                          Navigator.pop(context, File(''));
                        }
                      }),
                  const Text(
                    "Camera",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1),
                  )
                ],
              ),
              SizedBox(height: 0, width: 20),
              Column(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.image,
                        size: 22,
                      ),
                      onPressed: () async {
                        final file =
                            await pickImage(source: ImageSource.gallery);
                        File selected = File(file.path);
                        if (await selected.exists()) {
                          Navigator.pop(context, selected);
                        } else {
                          Navigator.pop(context, File(''));
                        }
                      }),
                  const Text(
                    "Gallery",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
