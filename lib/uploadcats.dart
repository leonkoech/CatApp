import 'dart:io';
import 'package:path/path.dart' as Path;

import 'package:async_loader/async_loader.dart';
import 'package:firebase_app/community.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart'; 
//upload cat info
//name
//weight
//lifespan
//images(new collection)
//Overview
//History

class UploadCats extends StatefulWidget {
  @override
  _UploadCatsState createState() => _UploadCatsState();
}

class _UploadCatsState extends State<UploadCats> {

  File _image;
  String postID;
  String catname;
  var _uploadedFileURL;
   final databaseReference= Firestore.instance;
  TextEditingController cat=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         _image != null
                          ? Padding(
                            padding: prefix0.EdgeInsets.fromLTRB(12, 0, 0, 12.3),
                            child:Image.file(
                            _image,
                            height: 150,
                          ) ,
                          )
                          : Container(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
                          child: TextField(
                     // onChanged: _onChanged,
                       controller: cat,
                     // focusNode: focus,
                      autofocus: true,
                      cursorColor: Colors.blue,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                      decoration: InputDecoration.collapsed(
                      hintText: "Cat Name",
                      ),
                      ),
            ), 
        FlatButton(
            child:Text('select image',
            style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
            onPressed: (){
              chooseFile();
            },
        ),
        FlatButton(
            child: Text('submit',
            style: TextStyle(color:Colors.white)
            ),
            color:Colors.blue,
            onPressed: (){
              catname=cat.text;
              createpost();
            },
        )        
        ],
      ),
          ),
    );
  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image; 
      });
    });
  }
  Future uploadPic() async {    
   StorageReference storageReferences = FirebaseStorage.instance    
       .ref()    
       .child('cats/${Path.basename(_image.path)}');    
   StorageUploadTask uploadTask = storageReferences.putFile(_image);  
         
   await uploadTask.onComplete;    
   print('File Uploaded');    
   await storageReferences.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });    
   });
  print(_uploadedFileURL);  
 }
   void clearSelection()  {
    setState(() {
      _image = null;
    });
  }
  Future createpost() async{
     //TO:DO 
    //if the date is today display 'today at (time)'
   // display=true;
   await uploadPic();
     DocumentReference ref = await databaseReference.collection("Cats")
      .add({
        'catname': catname,
        'Catimageurl': _uploadedFileURL,
        'type': 'short-haired'
        //'description': details!=null?details:null,
        
      });
      //add documentID under the username name
      //and the postDocumentIDs under the collection
      postID= ref.documentID; 
      print(postID);
          postID==null?showtoast('failed'):showtoast('uploaded');
          cat.clear();
          clearSelection();

  }
  showtoast(msg){
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white
        );
  }
}
class UploadMultipleCats extends StatefulWidget {
  final catID;
  
  const UploadMultipleCats({Key key, this.catID}) : super(key: key);
  @override
  _UploadMultipleCatsState createState() => _UploadMultipleCatsState(catID);
}

class _UploadMultipleCatsState extends State<UploadMultipleCats> {
  final catID;
File _image;
  String postID;
  String catname;
  var _uploadedFileURL;
   final databaseReference= Firestore.instance;
  _UploadMultipleCatsState(this.catID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
          body: Center(
        child:Column(
          mainAxisAlignment: prefix0.MainAxisAlignment.center,
          children: <Widget>[
          _image != null
                            ? Padding(
                              padding: prefix0.EdgeInsets.fromLTRB(12, 0, 0, 12.3),
                              child:Image.file(
                              _image,
                              height: 150,
                            ) ,
                            )
                            : Container(height: 10),

                                FlatButton(
              child:Text('select image',
              style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              onPressed: (){
                chooseFile();
              },
          ),
          FlatButton(
              child: Text('submit',
              style: TextStyle(color:Colors.white)
              ),
              color:Colors.blue,
              onPressed: (){
                //catname=cat.text;
                createpost();
              },
          )  
        ],)
         

      ),
    );
  }
    Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image; 
      });
    });
  }
  void clearSelection()  {
    setState(() {
      _image = null;
    });
  }
  Future createpost() async{
     //TO:DO 
    //if the date is today display 'today at (time)'
   // display=true;
   await uploadPic();
     DocumentReference ref = await databaseReference.collection("Cats").document(catID).collection('cat images')
      .add({
        'Catimageurl': _uploadedFileURL,
        //'description': details!=null?details:null,
      });
      //add documentID under the username name
      //and the postDocumentIDs under the collection
      postID= ref.documentID; 
      print(postID);
          postID==null?showtoast('failed'):showtoast('uploaded');
          //cat.clear();
          clearSelection();

  }
    Future uploadPic() async {    
   StorageReference storageReferences = FirebaseStorage.instance    
       .ref()    
       .child('cats/${Path.basename(_image.path)}');    
   StorageUploadTask uploadTask = storageReferences.putFile(_image);  
         
   await uploadTask.onComplete;    
   print('File Uploaded');    
   await storageReferences.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });    
   });
  print(_uploadedFileURL);  
 }
    showtoast(msg){
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white
        );
  }
}