import 'dart:io';
import 'dart:typed_data';

import 'package:demoapp/provider/imageprovider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  final ImagePicker _picker = ImagePicker();
  PickedFile? _image;
  Future openCamera() async {
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  // ignore: avoid_types_as_parameter_names
  Future<String> Save(Uint8List bytes) async {
    await [Permission.storage].request();
    final name = "final output";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result["filePath"];
  }

  @override
  // ignore: unnecessary_new
  Widget build(BuildContext context) {
    final data = Provider.of<Imagedataprovider>(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Demo app'),
        actions: [
          _image == null
              ? IconButton(
                  onPressed: openCamera,
                  icon: Icon(
                    Icons.upload_file,
                    size: 30,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    final name = "final output";
                    final saveimage = await screenshotController.capture();
                    Save(saveimage!);
                    // screenshotController
                    //     .capture(delay: Duration(milliseconds: 10))
                    //     .then((capturedImage) async {
                    //   ShowCapturedWidget(context, capturedImage!);
                    // }).catchError((onError) {
                    //   print(onError);
                    // });
                  },
                  icon: Icon(
                    Icons.save,
                    size: 30,
                  ),
                ),
          // IconButton(onPressed: () {

          // }, icon: icon)
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.imageclass.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Substyles(
                    name:data.imageclass[index].imagedata,
                  ),
                );
              },
            ),
          ),
          DragTarget<int>(builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 20,
                  right: 20,
                ),
                child: _image == null
                    ? Container(
                        height: 300,
                        color: Colors.amberAccent,
                      )
                    : Screenshot(
                        controller: screenshotController,
                        child: Stack(
                          children:[
                             Container(
                            height: 300,
                            color: Colors.amberAccent,
                            child: Image.file(File(_image!.path,),),
                          ),
                          Opacity(opacity:0.001,child: Image.network('https://upload.wikimedia.org/wikipedia/commons/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg'),),
      Opacity(opacity:0.2,child: Image.network('https://variety.com/wp-content/uploads/2021/07/Logan-Paul.jpeg'),),
                          ],
                        ),
                      ));
          })
        ],
      ),
      // new Stack(
      //   children: [
      //     Image.network('https://i.pinimg.com/originals/1b/f3/46/1bf3463c3ecd0911b891aecb7c11a91a.jpg'),
      //     Opacity(opacity:1,child: Image.network('https://upload.wikimedia.org/wikipedia/commons/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg'),),
      //     Opacity(opacity:1,child: Image.network('https://variety.com/wp-content/uploads/2021/07/Logan-Paul.jpeg'),),
      //           ],
    );

    // Future<dynamic> ShowCapturedWidget(
    //     BuildContext context, Uint8List capturedImage) {
    //   return showDialog(
    //     useSafeArea: false,
    //     context: context,
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(
    //         title: Text("Captured widget screenshot"),
    //       ),
    //       body: Center(
    //           child: capturedImage != null
    //               ? Image.memory(capturedImage)
    //               : Container()),
    //     ),
    //   );
    // }

    // _saved(File image) async {
    //   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
    //   print("File Saved to Gallery");
    // }
  }
}

class Substyles extends StatelessWidget {
  String name;
  // ignore: use_key_in_widget_constructors
  Substyles({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.lightGreenAccent,
        child: Image.network(name,fit: BoxFit.cover,),
      ),
      childWhenDragging: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.pinkAccent,
        child:  Image.network(name,fit: BoxFit.cover,),
      ),

      feedback: Container(
        color: Colors.deepOrange,
        height: 100,
        width: 100,
        child: Image.network(name,fit: BoxFit.cover,),
      ),
      // return Container(
      //   color: Colors.black,
      //   height: 50,
      //   width: 130,
      //   child: Image.network(name),
      // );
    );
  }
}
