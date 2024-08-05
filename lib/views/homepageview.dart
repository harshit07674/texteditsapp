
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:textediting/helpers/widgets/movables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textediting/viewmodels/textwidgetprovider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
//import these in the began of your .dart file
GlobalKey globalKey = new GlobalKey();


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? imageInMemory;
  String? imagePath;
  File? capturedFile;
  TextEditingController addText = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<Widget> textWidgets = [];
  File? imageFile;
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    return Consumer<TextWidgetProvider>(
      builder: (context,texts,child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              RepaintBoundary(
                key: globalKey,
                child: Container(
                  height: dimension.height*0.67,
                  width: dimension.width,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                    image: _image==null?DecorationImage(image: AssetImage("assets/white.jpg")):DecorationImage(image: FileImage(File(_image!.path)))
                  ),
                  child: Stack(
                    children: texts.widgetTexts,
                  ),
                ),
              ),
              SizedBox(height: dimension.height*0.1,),

              IconButton(onPressed: () async{
                capturePng();


              }, icon: Icon(Icons.download,color: Colors.black,size: 40,)),
              IconButton(onPressed: () async{
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                setState(() {
                  _image = image;
                });
              }, icon: Icon(Icons.photo,color: Colors.black,size: 50,)),

              IconButton(onPressed: () async{
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);

                setState(() {
                  _image = image;
                });
              }, icon: Icon(Icons.camera_alt_outlined,color: Colors.black,size: 50,)),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,size: 40,),
            onPressed: (){

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Enter Text'),
                    content: SingleChildScrollView(
                      reverse: true,
                      padding: EdgeInsets.only(bottom: dimension.height*0.03),
                      child: TextField(
                        controller: addText,
                        decoration: InputDecoration(hintText: 'Type something...'),
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: Text('OK'),
                        onPressed: () {
                          setState(() {
                            texts.add(MoveableStackItem(data: addText.text,));
                          });

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      }
    );
  }
  Future<Uint8List> capturePng() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
//create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
      imagePath = '$dir/file_name${DateTime.now()}.png';
      capturedFile = File(imagePath!);
      await capturedFile!.writeAsBytes(pngBytes);
      final result = await ImageGallerySaver.saveImage(pngBytes,
          quality: 60, name: "file_name${DateTime.now()}");
      return pngBytes;
    } catch (e) {
      throw e;
    }
  }
}
