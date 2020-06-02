import 'dart:async';
import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as Path;
import 'package:date_format/date_format.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'camera.dart';
import 'loginsignup.dart';
import 'main.dart';

 class Textarea extends StatefulWidget {
   final uiD;

  const Textarea({Key key, this.uiD}) : super(key: key);
   @override
   _TextareaState createState() => _TextareaState(uiD);
 }
 
 class _TextareaState extends State<Textarea> {
final uiD;
  final GlobalKey<AsyncLoaderState> asyncLoaderState =
new GlobalKey<AsyncLoaderState>();
var focus=new prefix0.FocusNode();
  File _image;
 var _uploadedFileURL;
 String postID;
 String cmp;
 String details;
 bool edit;
 String char;

  TextEditingController trl =  TextEditingController();

      int _charCount = 0;

  _TextareaState(this.uiD);

      _onChanged(String value) {
        setState(() {
          _charCount = value.length;
        });
      }
      
 final databaseReference= Firestore.instance;
 bool _saving=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(

  // Here we take the value from the MyHomePage object that was created by
  // the App.build method, and use it to set our appbar title.
  backgroundColor: Colors.white,
  elevation: 0.0,
      
      title: prefix0.Text(
        'New Post',
        style:TextStyle(color: Colors.black, 
        fontSize: 30,
        fontWeight: prefix0.FontWeight.bold,
        )
      ),
      
      actions: <Widget>[
        
         _charCount!=0? FlatButton(
            onPressed: () {
              //if submit button is clicked
              details=trl.text;
             // uploadPic();
              createpost();
            },
            textColor: Colors.white,
            padding: const EdgeInsets.fromLTRB(0.0,0.0,16.0,0.0),
            child:  ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child:Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              padding: const EdgeInsets.fromLTRB(12.0,6.0,12.0,6.0),
              child: const Text(
                'Purr Away',
                style: TextStyle(fontSize: 18.0)
              ),
            ),
        ),
        ):FlatButton(
            onPressed: () {
              //if submit button is clicked
             //Edit profile page;
            },
            disabledColor: Colors.black,
            
            padding: const EdgeInsets.fromLTRB(0.0,0.0,21.0,6.0),
            child: Text('nothing here'),
            // child: FutureBuilder<Widget>(
            //   future: getAvatar(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return snapshot.data;
            //     } else {
            //       return Text(' ');
            //     }
            //   },
            // ),
        ),
      ],     
      leading: Builder(
      builder: (BuildContext context) {
        return Container(
        margin: const EdgeInsets.only(left: 10.0),
          child: IconButton(
          iconSize: 34.0,
            icon: const Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () { 
              Navigator.pop(context);
              }
            )
        );
      },
      ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
            children: <Widget>[
                  
                  prefix0.Padding(
                    padding: prefix0.EdgeInsets.fromLTRB(12,12 , 1, 1),
                    child:TextField(
                  onChanged: _onChanged,
                   controller: trl,
                  focusNode: focus,
                  autofocus: true,
                  cursorColor: Colors.blue,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                  decoration: InputDecoration.collapsed(
                  hintText: "What's your cat up to?",
                  ),), 
                  ),
                
           Column(
             children: <Widget>[
                 Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _image != null
                            ? Padding(
                              padding: prefix0.EdgeInsets.fromLTRB(12, 0, 0, 12.3),
                              child:Image.file(
                              _image,
                              height: 150,
                            ) ,
                            )
                            : Container(height: 10),
                         
                               _image !=null?
                                 IconButton(
                                iconSize: 32.0,
                                icon:  const Icon(Icons.delete_forever,color: Colors.redAccent,),
                                onPressed: clearSelection,
                               )
                               :prefix0.Container(
                                 height: 10,
                               )
                             
                          
                        ],
                  ),
              Row(
               mainAxisAlignment: prefix0.MainAxisAlignment.spaceAround,
             children: <Widget>[
               Expanded(
                 flex: 1,
                 child: IconButton(
                 iconSize: 24.0,
                 icon:  const Icon(Icons.collections,color: Colors.blue,),
                  onPressed: chooseFile,
               ),
               ),
                Expanded(
                 flex: 1,
                 child:  IconButton(
                 iconSize: 24.0,
                 icon:  const Icon(Icons.gif,color: Colors.blue,),
                 onPressed: chooseFile,
                   
               ),
               ),
               Expanded(
                 flex: 1,
                 child:IconButton(
                 iconSize:24.0,
                 icon:   Icon(Icons.location_on,color:Colors.black12),
                 onPressed: null,
                 //color: Colors.blue,
               ),
               ),
               Expanded(
                 flex: 1,
                 child:  IconButton(
                 iconSize: 24.0,
                 
                 icon:   Icon(Icons.add_a_photo,color: Colors.blue,),
                  onPressed: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute<Navigator>(builder: (context) => Camerascreen()),
                    );
                   },
               ), 
               ),
               Flexible(
                 flex: 4,
                 child: progressindicator(_charCount.toDouble()),

               ),
               prefix0.Container(
                  width: 130,
                  child: _charCount>=80?prefix0.Text("Too long for a purr, but don't let me stop you!!",
                  style: prefix0.TextStyle(color: Colors.redAccent,
                  fontSize: 15,
                  fontWeight: prefix0.FontWeight.w500,
                  ),                
                  ):
               prefix0.Text(
                 
                    char=(_charCount.toString()+'/'+'80'),

                  style: prefix0.TextStyle(color: Colors.blue,
                  fontSize: 15,
                  fontWeight: prefix0.FontWeight.w500,
                  ), 
               ),
               alignment: _charCount>=80?prefix0.Alignment(0.0, 0.0):prefix0.Alignment(1.0, 1.0),
               ),
             ],
           )
             ],
           ),
           
            ],
          ),
        ),

      ),
    inAsyncCall: _saving);
}
   // final databaseReferencee = FirebaseDatabase.instance.reference();
var avatarUrl;
    Future getAvatar() async {
         FirebaseAuth.instance.currentUser().then((firebaseUser){
          if(firebaseUser == null)
          {
            //signed out
            setState(() {
              
            });
          }
          else{
            //signed in
            String uid=   firebaseUser.uid.toString();
            Firestore.instance.collection("UserAccounts").document(uid).get().then((datasnapshot) {
              if (datasnapshot.exists) {
              setState(() {
                avatarUrl=datasnapshot.data['profile picture'].toString();
              });
              }
              else{
               // print("No such user");
              }
              });
           } 
        }
        );
       
        //FirebaseUser user = await _firebaseAuth.currentUser();
    final Completer<Widget> completer = Completer();

    final url = avatarUrl;
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(Padding(
                  padding:prefix0.EdgeInsets.all(10), 
          child:
        prefix0.ClipRRect(
          borderRadius: prefix0.BorderRadius.circular(30),
          child: Image(image: image),
        )
        ));
    });

    load.addListener(listener);
    return completer.future;
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
 
 Future uploadPic() async {    
   StorageReference storageReferences = FirebaseStorage.instance    
       .ref()    
       .child('uploaded/${Path.basename(_image.path)}');    
   StorageUploadTask uploadTask = storageReferences.putFile(_image);  
   //switch uploadTask.isInProgress; 
       
   await uploadTask.onComplete;    
   print('File Uploaded');    
   await storageReferences.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });    
   });
  print(_uploadedFileURL);  
 }
   var username;

  Future getuserID() async{
final FirebaseUser user=await FirebaseAuth.instance.currentUser();        
            //signed in
            String uiD=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
              if (datasnapshot.exists) {
                setState(() {
                  //avatarUrl=datasnapshot.data['profile picture'];
                  username=datasnapshot.data['username'];
                });
                print (username);
                //print (avatarUrl);
              }
              else{
               // print("No such user");
              }
              });
          
        
}
  Future createpost() async{
     //TO:DO 
    //if the date is today display 'today at (time)'
   // display=true;
    setState(() {
      _saving = true;
    });

     new Future.delayed(new Duration(seconds: 6), () {
      setState(() {
        _saving = false;
      });
    });
   await uploadPic();
   await getuserID();
    String  date = formatDate(DateTime.now(), [d, '-', M]).toString();
    String time = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
     DocumentReference ref = await databaseReference.collection("UserPosts")
      .add({
        'username': username,
        'description': details!=null?details:null,
        'date': date,
        'time': time,
        ///condition? Text("True"): null,
        'imageurl': _uploadedFileURL!=null?_uploadedFileURL:null,
        'likes' : 0,
        'comments':0,
        'userID':uiD
      });
      //add documentID under the username name
      //and the postDocumentIDs under the collection
      
      postID= ref.documentID; 
      cmp=postID;
      switch (postID) {
        case null:
            prefix0.CircularProgressIndicator();
          break;
        default:
             Navigator.pop(context);
             Fluttertoast.showToast(
              msg: 'Sucessful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white
          );
          break;
      }
      print(postID);
      databaseReference.collection('UserPosts')
        .document( postID)
        .updateData({
          'postId': postID
          });
    // postID!=null?_showDialog(1):_showDialog(0);
     
      //   await databaseReference.collection("SingleUserPosts")
      // .document('leonkoech')
      // .setData({
      //   'postID': postID
      // });
  }

void updatePost() async {
  try {
    
    databaseReference
        .collection('UserPosts')
        .document( postID)
        .updateData({'description': 'Head First Flutter'});
    
  } catch (e) {
    print(e.toString());
  }
}
void deletePost() async{
  try {
    databaseReference
        .collection('UserPosts')
        .document(postID)
        .delete();
  } catch (e) {
    print(e.toString());
  }
}
void getPost() {
  databaseReference
      .collection("UserPosts")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => print('${f.data}}'));
  });
}
  Widget progressindicator(value){
        double _progressvalue = value/80;
  return   Container(
          margin: const EdgeInsets.all(10.0),
          width: 22.0,
          height: 22.0,
          child:LiquidCircularProgressIndicator(
          center: _progressvalue>=1?prefix0.Text('!',
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          )
          ):null,
          value: _progressvalue, // Defaults to 0.5.
          valueColor: _progressvalue>=1?AlwaysStoppedAnimation(Colors.redAccent):AlwaysStoppedAnimation(Colors.blue), // Defaults to the current Theme's accentColor.
          backgroundColor: _progressvalue>=1?Colors.redAccent:Colors.black12, // Defaults to the current Theme's backgroundColor.
          borderColor: Colors.black12,
          borderWidth: 0.0,
          direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
  ),);
  }
}
 //TO:DO
 //fetch data from firebase and display them
 class Community extends StatefulWidget {
   final username;
   final avatarUrl;
    final usernameID;
  const Community({Key key, this.username, this.avatarUrl, this.usernameID}) : super(key: key);
   @override
   _CommunityState createState() => _CommunityState(username,avatarUrl,usernameID);
 }
 
 class _CommunityState extends State<Community> {
  final username;
   final avatarUrl;
  final usernameID;
  _CommunityState(this.username, this.avatarUrl, this.usernameID);
   @override
   Widget build(BuildContext context) {
     return prefix0.Scaffold(
      appBar:AppbarCutomAvatar(topic: 'community',height: 105,avatarURL: avatarUrl,),
  body: Stack(
   // fit: prefix0.StackFit.expand,
    children: <Widget>[
      //  Row(
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                             //mainAxisAlignment = MainAxisAlignment.start,  
      //                             children:<Widget>[
      //                                AppbarCutomAvatar(topic:'community')

      //                             ]
      //                              ),
      // AppbarCutomAvatar(topic:'community'),
       Container(
              padding: const EdgeInsets.fromLTRB(10,0,10,5),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('UserPosts')
                  .snapshots(),
                builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    if (!snapshot.hasData)
                      return new Text('snap is null');
                    
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return new ListView(
                            children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                                if(snapshot.data.documents!=null){
                                return  new CustomCard(
                                  username: document['username'],
                                  description: document['description'],
                                  datePosted: document['date'],
                                  timePosted: document['time'],
                                  imageUrl: document['imageurl'],
                                  postID: document['postId'],
                                  nooflikes: document['likes'],
                                  noofcomments: document['comments'],
                                  usernameID: document['userID'],
                                );}
                                else{
                                  return new Text('empty');
                                }
                            }).toList(),
                          );
                      }
                    
                      
                    },
                )
                ),
              
    ],
  ),
      drawer: Sidedrawer(),
     floatingActionButton: prefix0.FloatingActionButton(
        onPressed: (
        ) {
              //signed in
                       Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>Textarea(uiD:usernameID))
                  );
                   },
      child: Icon(Icons.pets),
      backgroundColor: Colors.black,
      ),
     );
   }
    void _showDialog(BuildContext context) {
  //here I will create a boolean  and set it to false
    // flutter defined function
   showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //positive is 1 
          //negative is 0
          title: Text('Login'),
          content:  Text('Please login first to Post'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          
            new FlatButton(
              child:new Text('go back'),
              onPressed: (){
                Navigator.of(context).pop();
              },
              ),
                new FlatButton(
              child: new Text("Login",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.blue,
              onPressed: () {
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>SignuporLogin()));
               // trl.clear();
                
              },
             
            ), 
          ],
        );
      },
    );
  }
    Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();

    final url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTwSwzqAStInHW_ABFozyILjTpW7OBFtK3xyvI8jInSjR-wz8Xs';
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(Padding(
                  padding:prefix0.EdgeInsets.all(10), 
          child:
        prefix0.ClipRRect(
          borderRadius: prefix0.BorderRadius.circular(30),
          child: Image(image: image),
        )
        ));
    });

    load.addListener(listener);
    return completer.future;
  }
}
 class CustomCard extends StatelessWidget {
  CustomCard({@required this.username,@required this.description,@required this.datePosted,@required this.timePosted,@required this.imageUrl,@required this.postID, @required this.nooflikes, this.noofcomments, this.usernameID });
  //final preferredUsername;
  final  username;
  final description;
  final timePosted;
  final datePosted;
  final imageUrl;
  final postID;
  final nooflikes;
  final noofcomments;
  final usernameID;
  bool like;
   //final databaseReference= Firestore.instance;
  //final comments;
  String  dateToday = formatDate(DateTime.now(), [d, '-', M]).toString();
  String time = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
  @override
  Widget build(BuildContext context) {
    return  prefix0.GestureDetector(
         child: Container(
                        decoration: BoxDecoration(
                            // border: Border(
                            //  // top: BorderSide(width: 1.0, color: Colors.black12),
                            //   bottom: BorderSide(width: 1.0, color: Colors.black12),
                            // ),
                            
                            color: Colors.black,
                            borderRadius: prefix0.BorderRadius.circular(12)
                          ),
                          margin: prefix0.EdgeInsets.only(bottom: 12,left:8,right:8),
                      padding: //prefix0.EdgeInsets.all(10),
                      const EdgeInsets.fromLTRB(0,12.0,0,8),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child:Column(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          
                          prefix0.Padding(
                            padding: prefix0.EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child:Row(
                            mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: prefix0.BorderRadius.circular(20),

                                        ),
                                              child: FutureBuilder<Widget>(
                                                future: getPostAvatar(username),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return snapshot.data;
                                                  } else {
                                                    return Text(' ');
                                                  }
                                                },
                                              ),
                                      ), 
                                       prefix0.Column(
                                children: <Widget>[
                                  Text(
                                 '@'+username,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                )
                              ),
                                  FutureBuilder<Widget>(
                                                future: getPostPreferredName(username),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return snapshot.data;
                                                  } else {
                                                    return Text(' ');
                                                  }
                                                },
                                              ),
                                ],
                              ),
                                    ],
                                  )
                                ],
                              ),
                            
                              dateToday==datePosted?
                              Text(
                                time==timePosted?'Just now':'Today At '+ timePosted,
                              style: prefix0.TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                )
                              ):
                              Text(datePosted +' At ' + timePosted,
                              style: prefix0.TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                )
                              )
                            ],
                          )
                          
                          ),
                          prefix0.SizedBox(
                            height: 10,
                          ),
                          imageUrl!=null?
                            
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child:Image.network(imageUrl)
                            //   child: FutureBuilder<Widget>(
                            //   future: getImage(),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       return snapshot.data;
                            //     } else {
                            //       return Text(' ');
                            //     }
                            //   },
                            // )
                            )                     
                            :prefix0.Container(),
                           prefix0.SizedBox(
                            height: 10,
                          ),
                          description!=null?prefix0.Padding(
                            padding: prefix0.EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: prefix0.Row(
                            mainAxisAlignment: prefix0.MainAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            children:<Widget>[
                                Text(description,
                                style: prefix0.TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),),
                            ]
                            
                          ),

                          ):prefix0.Container(),
                          Row(
                            mainAxisAlignment: prefix0.MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: prefix0.MainAxisAlignment.start,
                                textDirection: prefix0.TextDirection.ltr,
                                children: <Widget>[
                                // IconButton(
                                  LikePost(like: like,postID: postID,userID:usernameID),
                              Container(
                                margin: prefix0.EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child:Text(nooflikes.toString()+' likes',
                                style: prefix0.TextStyle(color: Colors.white54),
                                )
                              )
                                ],
                              ),
                               Row(
                                 children:<Widget>[
                                   IconButton(
                                icon: Icon(Icons.mode_comment,
                                color: Colors.white54,
                                ),
                                iconSize: 24,
                                onPressed:(){
                                  //signed in
                                Navigator.push(context, prefix0.MaterialPageRoute(
                                            builder: (context)=>
                                              CommentPage(username:username,description: description,date: datePosted,time: timePosted,timeNow: time,dateToday: dateToday,postID: postID,),)
                                              );
                                              } 
                              ),
                              Container(
                                margin: prefix0.EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child:prefix0.Text(noofcomments.toString()+' comments',
                                style: TextStyle(color: Colors.white54),
                                ),
                              )
                              ]
                              ),
                              
                             
                             
                            ],
                          ),
                        ],
                      )
                     
                      )
                      ),
        onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Descriptiondetails(
                                  username:username,description: description,date: datePosted,time: timePosted,timeNow: time,dateToday: dateToday,imageUrl: imageUrl,postID: postID,likesnumber: nooflikes,)));
                    },
        
        );
  
  }
    Future <Widget> getPostPreferredName(usernamePost) async{
    String username;
   String preferrednames;
   
  Widget catcard;
  await Firestore.instance
        .collection('UserAccounts')
        .document(usernameID)
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
if(ds.exists){
//username=ds['username'];
        preferrednames=ds['preferred names'];
      if(usernamePost==ds['username']){
      catcard= new Text(
        preferrednames,
      style: TextStyle(
        color: Colors.white,
        fontWeight: prefix0.FontWeight.bold,
        fontSize: 19,
      )
      );

      }
      else{
        catcard=Container(
          color: Colors.red,
          height: 32,
          width: 32,
        );
      }
          
        }
    });
    return catcard;  
  }
  Future <Widget> getPostAvatar(usernamePost) async{
    //String username;
   String avatarurl;
  Widget catcard;
  
  await Firestore.instance
        .collection('UserAccounts')
        .document(usernameID)
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
if(ds.exists){
//username=ds['username'];
        //preferrednames=ds['preferred names'];
      if(usernamePost==ds['username']){
      catcard=  Container(
                  width: 32,
                   //padding: EdgeInsets.all(10),
                    //color: Colors.white,
                    margin: prefix0.EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                     //child: avatarURL!=null?Image.network(avatarURL):Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSYa_UviZTqw9XnbUGVfztzXaB-yd7ap5hBZA7yEE7RVnLR3pEF')
                      child: Image.network(ds['profile picture'].toString(),
                      fit: prefix0.BoxFit.cover,
                      ),
                    ),
                  );

      }
      else{
        catcard=Container(
          color: Colors.red,
          height: 32,
          width: 32,
        );
      }
          
        }
    });
    return catcard;  
   }
  void _showDialog(BuildContext context) {
  //here I will create a boolean  and set it to false
    // flutter defined function
   showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //positive is 1 
          //negative is 0
          title: Text('Login'),
          content:  Text('Please login first to comment'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          
            new FlatButton(
              child:new Text('Cancel',
              style: prefix0.TextStyle(color: Colors.blue),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
              ),
                new FlatButton(
              child: new Text("Login",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.black,
              onPressed: () {
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>SignuporLogin()));
               // trl.clear();
                
              },
             
            ), 
          ],
        );
      },
    );
  }
      Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();

    final url = imageUrl;
    if(imageUrl!=null){
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);
    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(
           Image(image: image),
        );
    });
    load.addListener(listener);
}
    
    return completer.future;
  
      }
}
class LikePost extends StatefulWidget {
  final bool like;
  final String postID;
  final String userID;
  LikePost({Key key,@required this.like,@required this.postID,@required this.userID});
  @override
  _LikePostState createState() => _LikePostState(like,postID,userID);
}

class _LikePostState extends State<LikePost> {
  bool like;
  final  userID;
  final postIDentity;
  _LikePostState(this.like, this.postIDentity, this.userID);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //check likestatus then set the bool like to likestatus
    Firestore.instance
        .collection('UserAccounts')
        .document(userID).collection('postsliked').document(postIDentity)
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
      if (ds.exists){
        if(ds.data['likestatus'].toString()=='true'){
          like=true;
        }
        else{
          like=false;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
              icon: like==true?Icon(Icons.favorite,
              color: Colors.red,
              ):Icon(Icons.favorite,
              color: Colors.white54,
              ),
              iconSize: 24,
              onPressed:(){
                  like==true?removeLikesNumber(postIDentity):addlikesNumber(postIDentity);
                
              } 
            );
  }
 Future addlikesNumber(postIDentity) async {
    setState(() {
          like=true;
        });
        final DocumentReference postRef = Firestore.instance.collection('UserPosts').document(postIDentity);
       await Firestore.instance.runTransaction((Transaction ul) async {
          DocumentSnapshot postSnapshot = await ul.get(postRef);
          if (postSnapshot.exists ) {
            await ul.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] + 1});
         
              ///add userid to likes document
               final databaseReference= Firestore.instance;
                 DocumentReference likeref= await databaseReference.collection('UserPosts')
                    .document( postIDentity).collection('likers')
                    .add({
                      //'postId': postID
                      'userid':[userID]
                      });
                      //add like id to some container
                      await databaseReference.collection('UserAccounts')
                      .document(userID).collection('postsliked').document(postIDentity)
                      .setData({
                       'likestatus':[true],
                       'likeref':likeref
                      });
                      //change bool like to true. This in turn changes the color of the icon to red
                        
                 //if liker does not exist set state to be true and if user does exist then init state should be true     

          //  await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] -1})
           
          }
        });
       // 
   }
    Future removeLikesNumber(postIDentity) async {
              setState(() {
                        like=false;
                      });
          final DocumentReference postRef = Firestore.instance.collection('UserPosts').document(postIDentity);
        await Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(postRef);
          if (postSnapshot.exists) {
           
            //remove user from likers
            //fetch 'like reference number' from UserAccounts first
               await Firestore.instance.collection("UserAccounts").document(userID)
               .collection('postsliked').document(postIDentity).get().then((datasnapshot) async {
              if (datasnapshot.exists)  {
                  var likeref;
                  var likestatus;
                  likeref=datasnapshot.data['likeref'];
                  likestatus=datasnapshot.data['likestatus'];
                print(likeref);
                print(likestatus.toString());
                //the likeref and likestatus have been fetched
                //now use the like ref to delete(likeref) from userposts &&
                //change like status to false
                
               final databaseReference= Firestore.instance;
                await databaseReference.collection('UserPosts')
                    .document( postIDentity).collection('likers')
                    .document(likeref).delete();
                      //change like status to some container
                      await databaseReference.collection('UserAccounts')
                      .document(userID).collection('postsliked').document(postIDentity)
                      .setData({
                       'likestatus':[false]
                      });
                     
               //by now the like has been removed. So go ahead and decrease the likes number
               await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] -1});
           
              }});

           //await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] -1})
           
          }
        });
     //   
   }

}






class Descriptiondetails extends StatefulWidget {
  final username;
  final description;
  final date;
  final time;
  final   dateToday;
  final  timeNow ;
  final imageUrl;
  final postID;
  final likesnumber;

  Descriptiondetails({Key key, @required this.username,@required this.description,@required this.date,@required this.time,@required this.dateToday,@required this.timeNow,this.imageUrl,@required this.postID, this.likesnumber});

  @override
  _DescriptiondetailsState createState() => _DescriptiondetailsState(username,description,date,time,dateToday,timeNow,imageUrl,postID,likesnumber);
}

class _DescriptiondetailsState extends State<Descriptiondetails> {
   final username;
  final description;
  final date;
  final time;
  final   dateToday;
  final  timeNow ;
  final imageUrl;
  final postID;
  final likesnumber;
  bool like;
  _DescriptiondetailsState(this.username, this.description, this.date, this.time, this.dateToday, this.timeNow, this.imageUrl, this.postID, this.likesnumber);
  @override
  Widget build(BuildContext context) {
     return prefix0.Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        // title: Text('Post Details',
        // style: TextStyle(color: Colors.black,
        //  fontWeight: FontWeight.bold, fontSize: 24
        // )
        // ),
        elevation: 0,
        
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 34,
          color: Colors.black,
          
          ),
          iconSize: 24,
          onPressed: () { 
            Navigator.pop(context);
            }
        ),
      ),
      body:Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10,5,0,5),
          child:  //call comment cards
        
            StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('UserPosts').document(postID).collection('Comments')
              .snapshots(),
            builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      scrollDirection: prefix0.Axis.vertical,
                      children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          
                          return new CommentCard(
                            username: document['username'],
                            commentDescription: document['comment description'],
                            dateposted: document['date'],
                            timeposted: document['time'],
                            commentID: document['commentID'],
                          );
                      }).toList(),
                    );
                }
              },
            ),

             
      //  ]
          //    ), 
              )
              ),
    
     floatingActionButton: prefix0.FloatingActionButton(
      onPressed: () {
         FirebaseAuth.instance.currentUser().then((firebaseUser){
            if(firebaseUser == null)
            {
              //signed out
              _showDialog(context);
              
            }
            else{
              //signed in
                     Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommentPage(username:widget.username,description: widget.description,date: widget.date,time: widget.time,timeNow: widget.timeNow,dateToday: widget.dateToday,postID: widget.postID,)));
        
            }
          });
      },
      
      child: Icon(Icons.comment,
      //size: 24,
      ),
      backgroundColor: Colors.black,
     ),
     );
  }
  void _showDialog(BuildContext context) {
  //here I will create a boolean  and set it to false
    // flutter defined function
   showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //positive is 1 
          //negative is 0
          title: Text('Login',
          style: prefix0.TextStyle(color: Colors.black),
          ),
          content:  Text('Please login first to Comment',
           style: prefix0.TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          
            new FlatButton(
              child:new Text("Cancel",
              style: prefix0.TextStyle(color: Colors.blue),
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
              ),
                new FlatButton(
              child: new Text("Login",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.black,
              onPressed: () {
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>SignuporLogin()
                  ));
               // trl.clear();
                
              },
             
            ), 
          ],
        );
      },
    );
  }
  comments(){
    
  }

       Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();

    final url = widget.imageUrl;
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(
          prefix0.ClipRRect(
            borderRadius: prefix0.BorderRadius.circular(20),
            child: Image(image: image),
          )
         
        );
    });

    load.addListener(listener);
    return completer.future;
  }

    Future<Widget> getAvatar() async {
    final Completer<Widget> completer = Completer();

    final url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTwSwzqAStInHW_ABFozyILjTpW7OBFtK3xyvI8jInSjR-wz8Xs';
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(Padding(
                  padding:prefix0.EdgeInsets.all(10), 
          child:
        prefix0.ClipRRect(
          borderRadius: prefix0.BorderRadius.circular(30),
          child: Image(image: image),
        )
        ));
    });

    load.addListener(listener);
    return completer.future;
  }
  
}
class CommentPage extends StatefulWidget {
  final username;
  final description;
  final date;
  final time;
  final postID;
  final String  dateToday;
  final String timeNow ;
  //details of the comment
  final cusername ;
  final ctimeposted;
  final cdateposted;
  final cimageurl;
  final cpostid;
  final clikesnumber;
  final ccommentsnumber;
  final cdescription;

  CommentPage({  @required this.username,@required this.description,@required this.date,@required this.time,@required this.dateToday,@required this.timeNow,@required this.postID, this.cusername, this.ctimeposted, this.cdateposted, this.cimageurl, this.cpostid, this.clikesnumber, this.ccommentsnumber, this.cdescription});

  @override
  _CommentPageState createState() => _CommentPageState(username,description,date,time,postID,dateToday,timeNow, cusername ,ctimeposted,cdateposted,cimageurl,cpostid,clikesnumber,ccommentsnumber, cdescription
  );
}

class _CommentPageState extends State<CommentPage> {
  final username;
  final description;
  final date;
  final time;
  final postID;
  final String  dateToday;
  final String timeNow ;
  final databaseReference = Firestore.instance;
  bool _saving = false;
final cusername ;
  final ctimeposted;
  final cdateposted;
  final cimageurl;
  final cpostid;
  final clikesnumber;
  final ccommentsnumber;
  final cdescription;
  String comment;

 final TextEditingController trl =  TextEditingController();

  _CommentPageState(this.username, this.description, this.date, this.time, this.postID, this.dateToday, this.timeNow, this.cusername, this.ctimeposted, this.cdateposted, this.cimageurl, this.cpostid, this.clikesnumber, this.ccommentsnumber, this.cdescription);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.9,
  color: Colors.black12,
  progressIndicator: CircularProgressIndicator(
   backgroundColor: Colors.blue,
  ),
  //offset: 
  dismissible: false,
      child: prefix0.Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Comment',
          style: prefix0.TextStyle(color: Colors.black,
           fontWeight: FontWeight.bold, fontSize: 24
          ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
            color: Colors.black,
            
            ),
            iconSize: 24,
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body:Column(
                    //mainAxisSize: prefix0.MainAxisSize.max,
                    mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                    children:<Widget>[  
                      Column(
                        children: <Widget>[
                           Row(
                        //mainAxisSize: prefix0.MainAxisSize.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Container(
                             width: MediaQuery.of(context).size.width,
                             decoration: BoxDecoration(
                              border: Border(
                                //top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                bottom: BorderSide(width: 1.0, color: Colors.black12),
                              ),
                              color: Colors.white,
                            ),
                            child:prefix0.Padding(
                            padding: prefix0.EdgeInsets.all(10),
                            child: Column(
                          mainAxisAlignment: prefix0.MainAxisAlignment.start,
                          crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                          children: <Widget>[
                            prefix0.Text(
                          'Replying to ',
                          style:TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          )
                        ),
                         prefix0.Text(
                          '@'+widget.username,
                          style:TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          )
                        ),
                          ],
                      ),
                          )
                          ),
                            
                        ],
                      ),
                       prefix0.Padding(
                                padding: prefix0.EdgeInsets.all(12),
                                child:  prefix0.TextField(
                                  controller: trl,
                              autofocus: true,
                              cursorColor: Colors.blue,
                              maxLines: 1,
                              style: prefix0.TextStyle(
                                fontSize: 18
                              ),
                              textInputAction: TextInputAction.newline,
                              textCapitalization: TextCapitalization.sentences,
                              autocorrect: true,
                              buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                              decoration: InputDecoration.collapsed(
                              hintText: "Thoughts?",
                            ),
                          ),
                              ),
                        ],
                      ),
                    
           Column(
             children: <Widget>[
               
              Row(
               mainAxisAlignment: prefix0.MainAxisAlignment.end,
             children: <Widget>[             
               
               prefix0.Container(
                 margin: prefix0.EdgeInsets.only(right: 12),
                  child:prefix0.FlatButton(
                     child: Text('Submit',
                     style: TextStyle(color: Colors.white,
                     fontSize: 16
                     ),
                     ),
                     color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(10.0),
                      splashColor: Colors.blue,
                      onPressed: () {
                        /*...*/
                        comment=trl.text;
                        comment!=null?addcomment(context,comment):_showDialog(context,0);
                      }
                   )
               ),
             ],
           )
             ],
           ),
                ]), 
      ),
   inAsyncCall: _saving, );
  
  }

    void _showDialog(BuildContext context,status) {
  //here I will create a boolean  and set it to false
    // flutter defined function

   showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //positive is 1 
          //negative is 0
          title: status==1?new Text('Success'):new Text('Error'),
          content: status==1?new Text('Your content has been uploaded'):new Text('Something went wrong.Try again later'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop(); 
                trl.clear();
                
              },
             
            ), 
            new FlatButton(
              child:new Text('edit post'),
              onPressed: (){
                Navigator.of(context).pop();
              },
              )
          ],
        );
      },
    );
  }

  String commentID;

  Future addcomment(context,comment) async{
        //add comment to firebase;
     setState(() {
      _saving = true;
    });
     new Future.delayed(new Duration(seconds: 4), () {
                setState(() {
                  _saving = false;
                });
              });
        await getusername();
        String  dateToday = formatDate(DateTime.now(), [d, '-', M]).toString();
        String timeNow = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
        DocumentReference ref= await Firestore.instance.collection('UserPosts').document(widget.postID).collection('Comments').add({
        'username': commenterusername,
        'comment description': comment,
        'date': dateToday,
        'time': timeNow,
      });
      //add number of comments after user has commented
        final DocumentReference postRef = Firestore.instance.collection('UserPosts').document(postID);
       await Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(postRef);
          if (postSnapshot.exists ) {
            await tx.update(postRef, <String, dynamic>{'comments': postSnapshot.data['comments'] + 1});           
          }
        });
      
      commentID= ref.documentID;
      if(commentID!=null){
           Fluttertoast.showToast(
              msg: "Successfully posted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
          prefix0.Navigator.push(context, prefix0.MaterialPageRoute(
            ////change to comments page
            builder: (context) =>Descriptiondetails(
                                  username:cusername,description: cdescription,date: cdateposted,time: ctimeposted,timeNow: timeNow,
                                  dateToday: dateToday,imageUrl: cimageurl,postID: postID,likesnumber: clikesnumber,))            
          );
           
      }
          // commentID!=null?_showDialog(context,1):_showDialog(context,0);

      await databaseReference.collection('UserPosts').document(widget.postID).collection('Comments').document(commentID)
            .updateData({
              'commentID': commentID
            });
   

  }

  var avatarUrl;

  var commenterusername;

Future getusername() async{
final FirebaseUser user=await FirebaseAuth.instance.currentUser();        
            //signed in
            String uiD=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
              if (datasnapshot.exists) {
                setState(() {
                  avatarUrl=datasnapshot.data['profile picture'];
                  commenterusername=datasnapshot.data['username'];
                });
                print (commenterusername);
                print (avatarUrl);
              }
              else{
               // print("No such user");
              }
              });     
}
}
class CommentCard extends StatefulWidget {
  final username;
  final dateposted;
  final timeposted;
  final commentDescription;
  final commentID;

   CommentCard({Key key,@required this.username,@required this.dateposted,@required this.timeposted,@required this.commentDescription,@required this.commentID});

  @override
  _CommentCardState createState() => _CommentCardState(username,dateposted,timeposted,commentDescription,commentID);
}

class _CommentCardState extends State<CommentCard> {
  final username;
  final dateposted;
  final timeposted;
  final commentDescription;
  final commentID;
final String  dateToday = formatDate(DateTime.now(), [d, '-', M]).toString();

final   String timeNow = (formatDate(DateTime.now(), [HH, ':', ss])).toString();

  _CommentCardState(this.username, this.dateposted, this.timeposted, this.commentDescription, this.commentID);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      child:Column( mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                prefix0.Padding(
                  padding: prefix0.EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child:  Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.start,
                    crossAxisAlignment: prefix0.CrossAxisAlignment.center,
                    children: <Widget>[

                       prefix0.Container(
                          height: 60,
                          child:  FutureBuilder<Widget>(
                              future: getAvatar(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data;
                                } else {
                                  return Text(' ');
                                }
                              },
                            )
                        ),
                        prefix0.Padding(
                          padding: prefix0.EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:  prefix0.Column(
                            mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                            children: <Widget>[
                              prefix0.Text(
                                widget.username,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                )
                              ),
                              Text('@'+widget.username,
                                style: prefix0.TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14
                                ),
                                ),
                            ],
                          )
                        )
                     
                       
                  
                    ],
                  ),
                ),
                prefix0.Padding(
                  padding: prefix0.EdgeInsets.fromLTRB(18, 6, 18, 10),
                  child:Text(widget.commentDescription,
                  style: prefix0.TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  ),
                ),
                  Container(  width: MediaQuery.of(context).size.width,
                           decoration: BoxDecoration(
                            border: Border(
                              //top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                              bottom: BorderSide(width: 1.0, color: Colors.black12),
                            ),
                            color: Colors.white,
                          ),
                          child: prefix0.Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.end,
                    children: <Widget>[
                      prefix0.Padding(
                        padding: prefix0.EdgeInsets.fromLTRB(0, 10, 10, 10),
                       child: dateToday==widget.dateposted?
                    Text(timeNow == widget.timeposted? 'Just Now ':'Today At '+ timeNow,
                    style: prefix0.TextStyle(
                        color: Colors.black12,
                        fontSize: 12,
                      )
                    ):
                    Text(widget.dateposted +' At ' + widget.timeposted,
                    style: prefix0.TextStyle(
                        color: Colors.black12,
                        fontSize: 12,
                      )
                    ),
                      ),
                       
                    ],
                  ),
        ),
                 
                ]  )
    );
  }

  var profileimageUrl;

    Future<Widget> getAvatar() async {
    final Completer<Widget> completer = Completer();
    await getpic();
    final url = profileimageUrl!=null?profileimageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTwSwzqAStInHW_ABFozyILjTpW7OBFtK3xyvI8jInSjR-wz8Xs';
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(Padding(
                  padding:prefix0.EdgeInsets.all(10), 
          child:
        prefix0.ClipRRect(
          borderRadius: prefix0.BorderRadius.circular(30),
          child: Image(image: image),
        )
        ));
    });

    load.addListener(listener);
    return completer.future;
  }

Future getpic() async{
final FirebaseUser user=await FirebaseAuth.instance.currentUser();        
            //signed in
            String uiD=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
              if (datasnapshot.exists) {
                setState(() {
                  profileimageUrl=datasnapshot.data['profile picture'];
                 // commenterusername=datasnapshot.data['username'];
                });
              //  print (commenterusername);
                print (profileimageUrl);
              }
              else{
               // print("No such user");
              }
              });
          
        
}
}











