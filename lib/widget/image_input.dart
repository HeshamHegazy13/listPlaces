import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    try {
      final picker = ImagePicker();
      final imageFile = await picker.getImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );

      setState(() {
        _storedImage = File(imageFile.path);
      });

      final appDir = await syspaths.getApplicationDocumentsDirectory();

      final fileName = path.basename(imageFile.path);
      final savedImage =
          await File(imageFile.path).copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('NO Image'),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          onPressed: _takePicture,
          // color: Theme.of(context).primaryColor,
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
        )),
      ],
    );
  }
}
