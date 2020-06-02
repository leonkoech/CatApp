import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show join;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as prefix0;
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
//import 'package:image_picker_modern/image_picker_modern.dart';

import 'dart:typed_data';


class Camerascreen extends StatefulWidget {
  @override
  _CamerascreenState createState() {
    return _CamerascreenState();
  }
}

class _CamerascreenState extends State<Camerascreen> {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;
  File _image;

  final GlobalKey _scaffoldKey = GlobalKey();

      Future opendevicecamera() async {
         await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image = image; 
      });
    });
      }
  
  @override
  void initState() {
    super.initState();

    // Get the list of available cameras.
    // Then set the first camera as selected.
    availableCameras()
        .then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      }
    })
        .catchError((dynamic err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
                color: Colors.black87,
        child: Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                    Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 535.0,
                      child: camera(),
                      ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                      child:Container(
                          margin: const EdgeInsets.only(top: 14.0, left: 3.0),
                       // color: Colors.red,
                        height: 64.0,
                        width:64.0,
                      child: IconButton(
                        icon: Icon(Icons.close,
                        color: Colors.white
                        ),
                        iconSize: 26,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                      //BackButton(color: Colors.white,),
                    )
                  ),
                   Align(
                    alignment: Alignment.topRight,
                      
                      child:  Container(
                        margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                        child:FlatButton(
                        textColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,21.0,6.0),
                                onPressed:opendevicecamera,
                                child:Container(
                                  
                                margin: const EdgeInsets.only(top: 14.0, left: 3.0),

                                
                                child:  ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child:Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  padding: const EdgeInsets.fromLTRB(12.0,6.0,12.0,6.0),
                                  child: const Text(
                                    'Open Device Camera',
                                    style: TextStyle(fontSize: 18.0)
                                  ),
                                ),
                            ),
                            ),),
     
       
       
                    )
                  ),
                      Align(
                      alignment: Alignment.bottomCenter,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children:<Widget>[
                        SizedBox(height: 620.0,), 
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 35, 0, 15),
                          child:controllers(),
                        )
                        
                        ],
                      ),
                      ),
                ]
              ),  
              ],
            ),
          ],
        ),
              
        
      )
      
        
 
    );
  }
  ///display the camera
  Widget camera(){
    return Stack(
                    children: <Widget>[
                    _cameraPreviewWidget(),
                    Align(
                      alignment:  Alignment.topCenter,
                      child: Gridart(400.0,535.0),
                    ),
                    ],
                  );
  }
///Displaying the bottom icons
  Widget controllers(){
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  _cameraTogglesRowWidget(),
                  
                  _captureControlRowWidget(),
                  
                  _thumbnailWidget(),
                  
                ],
          );
  }
  /// Display 'Loading' text when the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Transform.scale(
      scale: controller.value.aspectRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      ),
    );
  }

  /// Display the thumbnail of the captured image
  Widget _thumbnailWidget() {
    return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(

        child: imagePath == null
            ? SizedBox(width: 64,)
            : SizedBox(
          child: Image.file(File(imagePath)),
          width: 64.0,
          height: 64.0,
        ),
          onTap: (){
             
            Navigator.push(
              context,
              MaterialPageRoute<Navigator>(builder: (context) => PreviewImageScreen(
                imagePath: File(imagePath))),
            );
          },
      )
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _captureControlRowWidget() {
    return  Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          FloatingActionButton(
            child: Icon(Icons.camera),
            backgroundColor: Colors.blue,
            onPressed: controller != null &&
                controller.value.isInitialized
                ? _onCapturePressed
                : null,
          )
        ],
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras == null) {
      return Row();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return  Container(
      margin: EdgeInsets.only(left:10),
      child:Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: _onSwitchCamera,
        icon: Icon(
          _getCameraLensIcon(lensDirection),
          color: Colors.white,
          size: 35.0,
        ),
        //label: Text(''),
      ),

    ));
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.switch_camera;
      case CameraLensDirection.front:
        return Icons.switch_camera;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }
  
  Future _onCameraSwitched(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx = selectedCameraIdx < cameras.length - 1
        ? selectedCameraIdx + 1
        : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];

    _onCameraSwitched(selectedCamera);

    setState(() {
      selectedCameraIdx = selectedCameraIdx;
    });
  }
 Future _takePicture() async {
    if (!controller.value.isInitialized) {
      Fluttertoast.showToast(
          msg: 'Please wait',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white
      );

      return null;
    }

    // Do nothing if a capture is on progress
    if (controller.value.isTakingPicture) {
      return null;
    }
  
    final Directory appDirectory = await getExternalStorageDirectory();
    // set  the pictures directory
    final String pictureDirectory = '${appDirectory.path}/Pictures';
    //await Directory(pictureDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$pictureDirectory/$currentTime.jpg';
    // final String filePath = join(
    // Store the picture in the temp directory.
    // Find the temp directory using the `path_provider` plugin.
    //   (await getExternalStorageDirectory()).path,
    //   '${DateTime.now()}.png',
    // );
    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  void _onCapturePressed() {
    _takePicture().then((filePath) {
        if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        //if picture is saved
        if (filePath != null) {
          Fluttertoast.showToast(
              msg: 'Picture saved to $filePath',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white
          );
        }
      }
    });
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white
    );
  }

}

class PreviewImageScreen extends StatefulWidget {
  final File imagePath;

  PreviewImageScreen({@required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState(imagePath);
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  final File imagepath;
  _PreviewImageScreenState(this.imagepath);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(
                  File(imagepath.toString()), fit: BoxFit.cover)),
            SizedBox(height: 10.0),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: RaisedButton(
                  onPressed: () {
                    getBytesFromFile().then((bytes) {
                      Share.file('Share via:', prefix0.basename(imagepath.toString()),
                          bytes.buffer.asUint8List(), 'image/png');
                    });
                  },
                  child: Text('Share'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(imagepath.toString()).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}
class Gridart extends StatelessWidget {
  final width;
  final height;
  Gridart(this.width,this.height);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint( //                       <-- CustomPaint widget
        size: Size(width, height),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter { //         <-- CustomPainter class
  @override
void paint(Canvas canvas, Size size) {
  final p1 = Offset(0, 206);
  final p2 = Offset(400, 206);
   final p3 = Offset(0, 413);
  final p4 = Offset(400, 413); 
  final p5 = Offset(120, 5);
  final p6 = Offset(120, 620);
  final p7 = Offset(280, 5);
  final p8 = Offset(280, 620);
  final paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 0.2;
  canvas.drawLine(p1, p2, paint);
  canvas.drawLine(p3,p4,paint);
  canvas.drawLine(p5,p6,paint);
  canvas.drawLine(p7,p8,paint);
}
  
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
