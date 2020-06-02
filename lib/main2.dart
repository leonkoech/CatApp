import 'dart:async';
import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:date_format/date_format.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

 class Textarea extends StatefulWidget {
   @override
   _TextareaState createState() => _TextareaState();
 }
 
 class _TextareaState extends State<Textarea> {

  final GlobalKey<AsyncLoaderState> asyncLoaderState =
new GlobalKey<AsyncLoaderState>();
var focus=new prefix0.FocusNode();
  File _image;
 var _uploadedFileURL;
 String postID;
 String details;
 bool edit;
 String char;

  TextEditingController trl =  TextEditingController();

      int _charCount = 0;

      _onChanged(String value) {
        setState(() {
          _charCount = value.length;
        });
      }
      
 final databaseReference= Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Community()));
        
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
                onPressed: null,
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

    );
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
       .child('uploaded/${Path.basename(_image.path)}}');    
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
  Future createpost() async{
     //TO:DO 
    //if the date is today display 'today at (time)'
   // display=true;
   await uploadPic();
    String  date = formatDate(DateTime.now(), [d, '-', M]).toString();
    String time = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
     DocumentReference ref = await databaseReference.collection("UserPosts")
      .add({
        'username': 'leonkoech',
        'description': details!=null?details:null,
        'date': date,
        'time': time,
        ///condition? Text("True"): null,
        'imageurl': _uploadedFileURL!=null?_uploadedFileURL:null,
        'likes' : 0,
      });
      //add documentID under the username name
      //and the postDocumentIDs under the collection
      postID= ref.documentID; 
      print(postID);
      databaseReference.collection('UserPosts')
        .document( postID)
        .updateData({
          'postId': postID
          });
      // int positive=1;
      // int negative=0;
     //  postID!=null? display=true: display=false;
     postID!=null?_showDialog(1):_showDialog(0);
     
        await databaseReference.collection("SingleUserPosts")
      .document('leonkoech')
      .setData({
        'postID': postID
      });
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
void _showDialog(status) {
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
                // trl.clear();
                // clearSelection();
                edit=false;
              },
             
            ), 
            new FlatButton(
              child:new Text('edit post'),
              onPressed: (){
                Navigator.of(context).pop();
                edit=true;              
              },
              )
          ],
        );
      },
    );
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
  //a new dialog for when the user wants to delete a post
  void _showDeleteDialog() {
    // flutter defined function
    
    showDialog(
      context: context,
      barrierDismissible: true,

      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //positive is 1 
          //negative is 0
          title:  Text('Delete Post'),
          content:  Text('Are you sure you want to delete Post?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop(); 
                trl.clear();
                clearSelection();
              },
             
            ), 
            new FlatButton(
              child:new Text('Delete',
              style: TextStyle(color: Colors.red),
              ),
              onPressed: (){
                Navigator.of(context).pop();
               deletePost();

               showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                  return AlertDialog(

                      title:  postID.length==null?Text('Success'):Text('Error'),
                      content:  postID.length==null?Text('Your Post has been deleted'):Text('Your Post failed to delete'),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: postID==null?new Text("Done",
                          style: TextStyle(color: Colors.white),
                          ):new Text("Try Again",
                          style: TextStyle(color: Colors.white),
                          ),
                          //autofocus: true,
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).pop(); 
                            deletePost();
                            postID.length==null?trl.clear():null;
                            postID.length==null?clearSelection():null;
                          },
                        
                        ), 
                      ],
        );
                 }
               );
               
              },
              )
          ],
        );
      },
    );
  }
}
 //TO:DO
 //fetch data from firebase and display them
 class Community extends StatefulWidget {
   @override
   _CommunityState createState() => _CommunityState();
 }
 
 class _CommunityState extends State<Community> {

   @override
   Widget build(BuildContext context) {
     return prefix0.Scaffold(
       appBar: AppBar(backgroundColor: Colors.white,
  elevation: 0.0,
    title: prefix0.Text('Community',
    style: TextStyle (color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)
    ),
    
    actions: <Widget>[
     
        FlatButton(
          onPressed: () {
            //if submit button is clicked
           //Edit profile page;
          },
          textColor: Colors.white,
          padding: const EdgeInsets.fromLTRB(0.0,0.0,21.0,6.0),

          child: Padding(
                  padding:prefix0.EdgeInsets.all(10), 
          child:
        prefix0.ClipRRect(
          borderRadius: prefix0.BorderRadius.circular(30),
          child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTwSwzqAStInHW_ABFozyILjTpW7OBFtK3xyvI8jInSjR-wz8Xs'),
         
        )
        ) // child: FutureBuilder<Widget>(
          //   future: getImage(),
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
          icon: const Icon(Icons.menu,color: Colors.black,),
          onPressed: () { 
            Navigator.pop(context);
            }
          )
      );
    },
    ),
  ),
  body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
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
          ),
     floatingActionButton: prefix0.FloatingActionButton(
        onPressed: (
        ) {
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
                  builder: (context) =>Textarea()));
            }
          });
 
      },
      child: Icon(Icons.pets),
      backgroundColor: Colors.blue,
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
  CustomCard({@required this.username,@required this.description,@required this.datePosted,@required this.timePosted,@required this.imageUrl,@required this.postID, @required this.nooflikes});

  final  username;
  final description;
  final timePosted;
  final datePosted;
  final imageUrl;
  final postID;
  final nooflikes;
  int likes;
  bool like;
   //final databaseReference= Firestore.instance;
  //final comments;
  String  dateToday = formatDate(DateTime.now(), [d, '-', M]).toString();
      String time = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        //color: prefix0.Color.fromRGBO(232, 232, 232, 0.7),
        child: prefix0.GestureDetector(
         child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                              //top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                              bottom: BorderSide(width: 1.0, color: Colors.black12),
                            ),
                            color: Colors.white,
                          ),
                      padding: const EdgeInsets.fromLTRB(0,8.0,0,8),
                      child: Column(
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          prefix0.Padding(
                            padding: prefix0.EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child:Row(
                            mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                 '@'+username,
                                style: TextStyle(
                                  color: Colors.black12,
                                  fontSize: 16,
                                )
                              ),
                              dateToday==datePosted?
                              Text(
                                time==timePosted?'Just now':'Today At '+ timePosted,
                              style: prefix0.TextStyle(
                                  color: Colors.black12,
                                  fontSize: 14,
                                )
                              ):
                              Text(datePosted +' At ' + timePosted,
                              style: prefix0.TextStyle(
                                  color: Colors.black12,
                                  fontSize: 14,
                                )
                              )
                            ],
                          )
                          
                          ),
                          prefix0.SizedBox(
                            height: 10,
                          ),
                          prefix0.Padding(
                            padding: prefix0.EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: prefix0.Row(
                            mainAxisAlignment: prefix0.MainAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            children:<Widget>[
                                Text(description,
                                style: prefix0.TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),),
                            ]
                            
                          ),

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
                          Row(
                            mainAxisAlignment: prefix0.MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: prefix0.MainAxisAlignment.start,
                                textDirection: prefix0.TextDirection.ltr,
                                children: <Widget>[
                                // IconButton(
                                  LikePost(like: like,postID: postID,),
                              Container(
                                margin: prefix0.EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child:Text(nooflikes.toString()+' likes',
                                style: prefix0.TextStyle(color: Colors.black12),
                                )
                              )
                                ],
                              ),
                               Column(
                                 children:<Widget>[
                                   IconButton(
                                icon: Icon(Icons.mode_comment,
                                color: Colors.black12,
                                ),
                                iconSize: 24,
                                onPressed:(){
                                   Navigator.push(context, prefix0.MaterialPageRoute(
                                   builder: (context)=>
                                     CommentPage(username:username,description: description,date: datePosted,time: timePosted,timeNow: time,dateToday: dateToday,postID: postID,)
                                     ,));
                                } 
                              ),
                              Container(
                                margin: prefix0.EdgeInsets.fromLTRB(28, 0, 0, 0),
                                child:prefix0.Text('0 comments'),
                              )
                              ]
                              ),
                              
                             
                             
                            ],
                          ),
                        ],
                      )
                      ),
        onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Descriptiondetails(
                                  username:username,description: description,date: datePosted,time: timePosted,timeNow: time,dateToday: dateToday,imageUrl: imageUrl,postID: postID,)));
                    },
        
        ),
        
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

  LikePost({Key key,@required this.like,@required this.postID});
  @override
  _LikePostState createState() => _LikePostState(like,postID);
}

class _LikePostState extends State<LikePost> {
  bool like;
  final postIDentity;
  _LikePostState(this.like, this.postIDentity);
  @override
  Widget build(BuildContext context) {
    return IconButton(
              icon: like==true?Icon(Icons.favorite,
              color: Colors.red,
              ):Icon(Icons.favorite,
              color: Colors.black12,
              ),
              iconSize: 24,
              onPressed:(){
                  like==true?removeLikesNumber(postIDentity):addlikesNumber(postIDentity);
                
              } 
            );
  }

int oldnumber;
int newnumber;
 Future addlikesNumber(postIDentity) async {
   
          final DocumentReference postRef = Firestore.instance.collection('UserPosts').document(postIDentity);
       await Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(postRef);
          if (postSnapshot.exists ) {
            await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] + 1});
            setState(() {
                like=true;
              })
          //  await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] -1})
           ;
          }
        });
       // 
   }
    Future removeLikesNumber(postIDentity) async {
   
          final DocumentReference postRef = Firestore.instance.collection('UserPosts').document(postIDentity);
        await Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(postRef);
          if (postSnapshot.exists) {
           await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] -1});
           setState(() {
                like=false;
              })
           //await tx.update(postRef, <String, dynamic>{'likes': postSnapshot.data['likes'] -1})
           ;
          }
        });
     //   
   }

}






class Descriptiondetails extends StatelessWidget {
  final username;
  final description;
  final date;
  final time;
  final   dateToday;
  final  timeNow ;
  final imageUrl;
  final postID;

  Descriptiondetails({Key key, @required this.username,@required this.description,@required this.date,@required this.time,@required this.dateToday,@required this.timeNow,this.imageUrl,@required this.postID});
  
  @override
  Widget build(BuildContext context) {
     return prefix0.Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Post Details',
        style: TextStyle(color: Colors.black,
         fontWeight: FontWeight.bold, fontSize: 24
        )
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.black,
          
          ),
          iconSize: 24,
          onPressed: () { 
            Navigator.pop(context);
            }
        ),
      ),
      body:new Container(
  child: new SingleChildScrollView(
    child:Wrap(
        direction: prefix0.Axis.horizontal,
        children:<prefix0.Widget>[Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                prefix0.Padding(
                  padding: prefix0.EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child:  Row(
                    mainAxisAlignment: prefix0.MainAxisAlignment.start,
                    crossAxisAlignment: prefix0.CrossAxisAlignment.center,
                    children: <Widget>[

                       prefix0.Container(
                          height: 70,
                          child:  Padding(
                                      padding:prefix0.EdgeInsets.all(10), 
                              child:
                            prefix0.ClipRRect(
                              borderRadius: prefix0.BorderRadius.circular(30),
                              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTwSwzqAStInHW_ABFozyILjTpW7OBFtK3xyvI8jInSjR-wz8Xs'),
                            )
                            )
                        ),
                        prefix0.Padding(
                          padding: prefix0.EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:  prefix0.Column(
                            mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                            children: <Widget>[
                              prefix0.Text(
                                username,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                )
                              ),
                              Text('@'+username,
                                style: prefix0.TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16
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
                  child:Text(description+'shdfjskdhvsjfhsdjfhsvdfjsdhvsjhvsjfvsfjdvf'
                  +'dhsfjsfhvjfhsvdfsdfvjfhvsjdsvfsfjsfjdsvhfjdfhvsjdfhvsjdfhvsfsjvdhf'
                  +'sdhfvsjdfhvdfjhsdfjhsdvfjdvfhjdvfjsdfhvjfsdfsdfsdjfsvdfjdfvdjfvdhf'
                  +'shdfjskdhvsjfhsdjfhsvdfjsdhvsjhvsjfvsfjdvf'
                  +'dhsfjsfhvjfhsvdfsdfvjfhvsjdsvfsfjsfjdsvhfjdfhvsjdfhvsjdfhvsfsjvdhf'
                  +'sdhfvsjdfhvdfjhsdfjhsdvfjdvfhjdvfjsdfhvjfsdfsdfsdjfsvdfjdfvdjfvdhf'
                  +'shdfjskdhvsjfhsdjfhsvdfjsdhvsjhvsjfvsfjdvf'
                  +'dhsfjsfhvjfhsvdfsdfvjfhvsjdsvfsfjsfjdsvhfjdfhvsjdfhvsjdfhvsfsjvdhf'
                  +'sdhfvsjdfhvdfjhsdfjhsdvfjdvfhjdvfjsdfhvjfsdfsdfsdjfsvdfjdfvdjfvdhf'
                  
                  ,
                  style: prefix0.TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),
                  ),
                ),
                imageUrl!=null?
                FutureBuilder<Widget>(
                    future: getImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data;
                      } else {
                        return Text(' ');
                      }
                    },
                  )
                  :prefix0.Container(),
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
                       child: dateToday==date?
                    Text(timeNow == time? 'Just Now ':'Today At '+ timeNow,
                    style: prefix0.TextStyle(
                        color: Colors.black12,
                        fontSize: 14,
                      )
                    ):
                    Text(date +' At ' + time,
                    style: prefix0.TextStyle(
                        color: Colors.black12,
                        fontSize: 14,
                      )
                    ),
                      ),
                       
                    ],
                  ),
        ),
                 
                    //comments if any
                    //call comment cards
            StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('UserPosts').document(postID).collection('comments')
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

              ]),
        ]
              ), 
    )
    ),
     floatingActionButton: prefix0.FloatingActionButton(
      onPressed: () {
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommentPage(username:username,description: description,date: date,time: time,timeNow: timeNow,dateToday: dateToday,postID: postID,)));
        
          
      },
      
      child: Icon(Icons.comment),
      backgroundColor: Colors.blue,
     ),
     );
  }
       Future<Widget> getImage() async {
    final Completer<Widget> completer = Completer();

    final url = imageUrl;
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(
          Image(image: image),
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

  CommentPage({  @required this.username,@required this.description,@required this.date,@required this.time,@required this.dateToday,@required this.timeNow,@required this.postID});

  @override
  _CommentPageState createState() => _CommentPageState(username,description,date,time,postID,dateToday,timeNow);
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

  String comment;

 final TextEditingController trl =  TextEditingController();

  _CommentPageState(this.username, this.description, this.date, this.time, this.postID, this.dateToday, this.timeNow);

  @override
  Widget build(BuildContext context) {
    return prefix0.Scaffold(
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
    );
  
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
        await getusername();
        String  dateToday = formatDate(DateTime.now(), [d, '-', M]).toString();
        String timeNow = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
        DocumentReference ref= await Firestore.instance.collection('UserPosts').document(widget.postID).collection('Comments').add({
        'username': commenterusername,
        'comment description': comment,
        'date': dateToday,
        'time': timeNow,
      });
      
      commentID= ref.documentID;
           commentID!=null?_showDialog(context,1):_showDialog(context,0);

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
            String uid=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uid).get().then((datasnapshot) {
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
class CommentCard extends StatelessWidget {
  final username;
  final dateposted;
  final timeposted;
  final commentDescription;
  final commentID;
final String  dateToday = formatDate(DateTime.now(), [d, '-', M]).toString();
final   String timeNow = (formatDate(DateTime.now(), [HH, ':', ss])).toString();
   CommentCard({Key key,@required this.username,@required this.dateposted,@required this.timeposted,@required this.commentDescription,@required this.commentID});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                          height: 70,
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
                                username,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                )
                              ),
                              Text('@'+username,
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
                  child:Text(commentDescription+'shdfjskdhvsjfhsdjfhsvdfjsdhvsjhvsjfvsfjdvf'
                  +'dhsfjsfhvjfhsvdfsdfvjfhvsjdsvfsfjsfjdsvhfjdfhvsjdfhvsjdfhvsfsjvdhf'
                  +'sdhfvsjdfhvdfjhsdfjhsdvfjdvfhjdvfjsdfhvjfsdfsdfsdjfsvdfjdfvdjfvdhf'
                  +'shdfjskdhvsjfhsdjfhsvdfjsdhvsjhvsjfvsfjdvf'
                  +'dhsfjsfhvjfhsvdfsdfvjfhvsjdsvfsfjsfjdsvhfjdfhvsjdfhvsjdfhvsfsjvdhf'
                  +'sdhfvsjdfhvdfjhsdfjhsdvfjdvfhjdvfjsdfhvjfsdfsdfsdjfsvdfjdfvdjfvdhf'
                  +'shdfjskdhvsjfhsdjfhsvdfjsdhvsjhvsjfvsfjdvf'
                  +'dhsfjsfhvjfhsvdfsdfvjfhvsjdsvfsfjsfjdsvhfjdfhvsjdfhvsjdfhvsfsjvdhf'
                  +'sdhfvsjdfhvdfjhsdfjhsdvfjdvfhjdvfjsdfhvjfsdfsdfsdjfsvdfjdfvdjfvdhf'
                  
                  ,
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
                       child: dateToday==dateposted?
                    Text(timeNow == timeposted? 'Just Now ':'Today At '+ timeNow,
                    style: prefix0.TextStyle(
                        color: Colors.black12,
                        fontSize: 12,
                      )
                    ):
                    Text(dateposted +' At ' + timeposted,
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












class SignuporLogin extends StatefulWidget {
  
  @override
  _SignuporLoginState createState() => _SignuporLoginState();
}

class _SignuporLoginState extends State<SignuporLogin> {
  
 File profileimage;
   var _uploadedFileURL;

  var profileurl; 
  String _email;
  String _password;
  String _username;
  String _confirmpassword;
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final databaseReference= Firestore.instance;
  prefix0.TextEditingController passwordcontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController confirmpasswordcontroller=new TextEditingController();
    TextEditingController usernamecontroller=new TextEditingController();

  var nokey;

  //var head;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            leading: prefix0.IconButton(
              iconSize: 36,
              icon: Icon(Icons.close,color: Colors.black),
            onPressed: (){
              Navigator.pop(context);
               },
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: prefix0.Text('Cats App',
            style: prefix0.TextStyle(color: Colors.black,
            fontSize: 46,
            fontWeight: FontWeight.bold, 
             ),
            ),
          )
        ),
            body: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar:  TabBar(
                  //indicatorSize: TabBarIndicatorSize.tab,
                  // indicator: const BubbleTabIndicator(
                  //     indicatorHeight: 26.0,
                  //     indicatorRadius: 12,
                  //     indicatorColor: Colors.blue,
                  //     tabBarIndicatorSize: TabBarIndicatorSize.tab,),
                  indicatorColor: Colors.blue,
                  indicatorPadding: prefix0.EdgeInsets.fromLTRB(10, 0, 10, 12),
                  indicatorWeight: 2,
                    labelColor: Colors.blue,
                    labelStyle: const TextStyle(fontFamily: 'Futura',fontSize: 16.0,fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: const TextStyle(fontFamily: 'Futura',fontSize: 16.0,fontWeight: FontWeight.bold),
                    isScrollable: true,
                    tabs:[
                  const Tab(
                      text: 'Sign Up',
                       ),
                  const Tab(
                      text: 'Login',
                       ),
                  
                ],
                  ),
                
                body: TabBarView(
                 children: <Widget>[
                  ListView(
              shrinkWrap:true,children:<Widget>[signup()] ),
              ListView(
              children:<Widget>[login()] ),
                  
               
               ]
               )
               )
               ),
               );
  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        profileimage = image; 
      });
    });
  }
  void clearSelection()  {
    setState(() {
      profileimage = null;
    });
  }
   Future postAvatar() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('UserAvatars/${Path.basename(profileimage.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(profileimage);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   await storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       profileurl = fileURL;    
     });    
   });
  // print(_uploadedFileURL);  
 }
 
 Widget login(){
   //settitle('Login');
    return  Column(
         children: <Widget>[
             Row(
               crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                children: <Widget>[
                SizedBox(
                  width:20
                ),
                Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
                ),
              ),
                ],
              ),
             
                prefix0.SizedBox(
                height: 210,
              
              ),
              showEmailInput(),
              showPasswordInput(),
              
           Padding(
            padding: prefix0.EdgeInsets.fromLTRB(20,20,20,0),
            child: Column(
            mainAxisAlignment: prefix0.MainAxisAlignment.start,
                  crossAxisAlignment: prefix0.CrossAxisAlignment.stretch,
            children: <Widget>[ 
              prefix0.Text('Forgot Password?'),
              prefix0.SizedBox(height: 10),
         FlatButton(
            child: prefix0.Text('LOGIN',
            style: prefix0.TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
            ),
            onPressed:  (){
              _username=usernamecontroller.text;
              _password=passwordcontroller.text;
              _email=emailcontroller.text;
              logIn();
            },
            color: Colors.black,
            padding: prefix0.EdgeInsets.fromLTRB(80, 15, 80, 15),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: prefix0.MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          Text('OR',
          style:prefix0.TextStyle(color:prefix0.Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),)
        ],),
        
        SizedBox(
          height: 5,
        ),
        OutlineButton(
            child: prefix0.Text('LOGIN WITH FACEBOOK',
            style: prefix0.TextStyle(
              color: Colors.blue,
              fontSize: 18
            ),
            ),
            onPressed: null,
            disabledBorderColor: Colors.blue,
            padding: prefix0.EdgeInsets.fromLTRB(80, 15, 80, 15),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton(
            child: prefix0.Text('SIGN IN WITH GOOGLE',
            style: prefix0.TextStyle(
              color: Colors.black,
              fontSize: 18
            ),
            ),
            onPressed:null,
            disabledColor: 
            Colors.black12,
            padding: prefix0.EdgeInsets.fromLTRB(80, 15, 80, 15),
        ), 
        prefix0.SizedBox(
          height: 20,
        )
        ],
          )
          ),
          
       ],
       )
    ;
  
 }
Widget signup(){
 //settitle('Sign Up');
  return Column(   
           mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,  
           //crossAxisAlignment: prefix0.CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                SizedBox(
                  width:20
                ),
                Text(
                'Personal Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
                ),
              ),
                ],
              ),
             
          prefix0.SizedBox(
            height: 10,
          ),
          GestureDetector(
            
            child: profileimage==null?Container(
              
          // height: 80,
           decoration: new BoxDecoration(
              color: Colors.transparent,
            ),
             height: 100,
             padding: prefix0.EdgeInsets.fromLTRB(0,0, 0, 0),
              child:
              Stack(
                children: <Widget>[
                  Align(
                    alignment: prefix0.Alignment.center,
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: Colors.black26,
                        shape: CircleBorder(),
                      ),
                      child:prefix0.IconButton(
                            iconSize: 80,
                            icon: Icon(Icons.person,
                            color: Colors.black12,),
                            onPressed: null,
                          
                          )
                      )
                  ),
                 
                  Align(
                    alignment: Alignment(0,0),
                  child: prefix0.GestureDetector(
                    child: Icon(
                      
                      Icons.add_a_photo,
                      size: 35,
                      color: Colors.white70,
                      ),
                    onTap: chooseFile,
                  ) 
                  )
                ],
              )
            ):Container(
              
          // height: 80,
           decoration: new BoxDecoration(
              color: Colors.transparent,
            ),
             height: 100,
             padding: prefix0.EdgeInsets.fromLTRB(0,0, 0, 0),
              child:
              Stack(
                //key: nokey,
                children: <Widget>[
                  Align(
                    alignment: prefix0.Alignment.center,
                    child: ClipRRect(

                  borderRadius: BorderRadius.circular(120.0),
                    child: prefix0.Image.file(profileimage),
                  ),
                  ),
                 
                  Align(
                    alignment: Alignment(0.26,1),
                  child: prefix0.GestureDetector(
                    child: Icon(Icons.remove_circle),
                    onTap: clearSelection,
                  ) 
                  )
                ],
              )
            ),
          
          onTap: chooseFile,
          ),
         // showUsernameInput(),
          form(),         
      ],);
      
    
}
Widget form(){
  return Container(
    child: Column(
      crossAxisAlignment: prefix0.CrossAxisAlignment.start,
      children: <Widget>[
         showEmailInput(),
         prefix0.SizedBox(height: 10,),
          showUsernameInput(),
                   prefix0.SizedBox(height: 10,),
          showPasswordInput(),
                   prefix0.SizedBox(height: 10,),
          showConfirmPasswordInput(),
          Padding(
            padding: prefix0.EdgeInsets.all(20),
            
          child: Text(
            'By Clicking Sign up you decree that you have \nread and thereby accept our Terms and \nConditions'
          ),
          
          ),
           Padding(
            padding: prefix0.EdgeInsets.fromLTRB(20,0,20,0),
            child: Column(
            mainAxisAlignment: prefix0.MainAxisAlignment.center,
                  crossAxisAlignment: prefix0.CrossAxisAlignment.stretch,
            children: <Widget>[
         FlatButton(
            child: prefix0.Text('SIGN UP',
            style: prefix0.TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
            ),
            onPressed: (){
              _username=usernamecontroller.text;
              _email=emailcontroller.text;
              _password=passwordcontroller.text;
              _confirmpassword=confirmpasswordcontroller.text;
              _password==_confirmpassword?postAvatar():_showDialog(0,'Passwords Do Not Match');
              
              signUp();
            },
            color: Colors.black,
            padding: prefix0.EdgeInsets.fromLTRB(80, 15, 80, 15),
        ), ],
          )
          ),
          SizedBox(
            height: 20,
          )
       
      ],
    ),
  );

         
}

Widget showEmailInput() {
  FocusNode myFocusNode1 = new FocusNode();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: new TextFormField(
        focusNode: myfocusnode3,
        controller: emailcontroller,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Email',
            labelStyle: prefix0.TextStyle(
              color:  _colorlabel(myfocusnode3),
              
              
            ),
           focusedBorder:UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue)
           )
         
            ),
        // validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        // onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
FocusNode myFocusNode2 = new FocusNode();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: new TextFormField(
        controller: passwordcontroller,
        maxLines: 1,
        focusNode: myfocusnode2,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Password',
              labelStyle: prefix0.TextStyle(
               
              color:  _colorlabel(myfocusnode2),
              
              
            ),
           focusedBorder:UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue)
           )
          
            ),
        validator: (value) => value.isEmpty? 'Password can\'t be empty' : null,
        // onSaved: (value) => _password = value.trim(),
      ),
    );
  }
   Widget showConfirmPasswordInput() {
     FocusNode myFocusNode3 = new FocusNode();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: new TextFormField(
        focusNode: myfocusnode1,
        controller: confirmpasswordcontroller,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: prefix0.TextStyle(
              color:  _colorlabel(myfocusnode1),
              
              
            ),
           focusedBorder:UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue)
           )
          
            ),
         validator: (value) =>passwordcontroller.text!=null?"passwords don't match":null,
        // onSaved: (value) => _password = value.trim(),
      ),
    );
  }
   FocusNode _focusNode;
   FocusNode myfocusnode1;
      FocusNode myfocusnode2;
   FocusNode myfocusnode3;

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
myfocusnode1.dispose();
myfocusnode2.dispose();
myfocusnode3.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
    myfocusnode2=new prefix0.FocusNode();
    myfocusnode2.addListener(_onOnFocusNodeEvent);
    myfocusnode1=new prefix0.FocusNode();
    myfocusnode1.addListener(_onOnFocusNodeEvent);
    myfocusnode3=new prefix0.FocusNode();
    myfocusnode3.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }
  
  Color _colorlabel(x){
    return x.hasFocus ? Colors.blue : Colors.grey;
    
  }
     Widget showUsernameInput() {
      // FocusNode myFocusNode4 = new FocusNode();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: new TextFormField(
        focusNode: _focusNode,
        controller: usernamecontroller,
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        decoration: new InputDecoration(
            //hintText: 'Username',
            labelText: 'Username',
            focusColor: Colors.blue,
            labelStyle: prefix0.TextStyle(
              color:  _colorlabel(_focusNode),
              
              
            ),
           focusedBorder:UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue)
           )
            ),
             
         //validator: (value) =>passwordcontroller.text!=null?"passwords don't match":null,
        // onSaved: (value) => _password = value.trim(),
      ),
    );
  }
   Future<String> signUp() async{
  AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email, password: _password).catchError((signUpError) {
              if(signUpError is PlatformException) {
                if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                  _showDialog(0,'Email already in use');
                }
                if(signUpError.code=='ERROR_INVALID_EMAIL'){
                  _showDialog(0, 'Email is invalid');
                }
                 if(signUpError.code=='ERROR_WEAK_PASSWORD'){
                  _showDialog(0, 'Password is too weak');
                }
            }
});
    FirebaseUser user = result.user;
      await databaseReference.collection("UserAccounts").document(user.uid)
      .setData({
        'username': _username==null?'CatApp user':_username,
        'preferred names': _username!=null?_username:null,
        'profile picture': profileurl!=null?profileurl:null,
        'email': _email,
      });
user.uid!=null?_showDialog(1,'user succesully added'):_showDialog(0,'There was an error.\nPlease try again later');
    return user.uid;
  }  
   Future<String> logIn() async{
   AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email, password: _password);
    FirebaseUser user = result.user;
   
//user.uid!=null?_showDialog(1):_showDialog(0);
    return user.uid;
  }
   Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
void _showDialog(status,error) {
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
          content: Text(error),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(
              child: new Text("Close",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: status==1?Colors.blue:Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop(); 
                // trl.clear();
                // clearSelection();
                //edit=false;
              },
             
            ), 
          ],
        );
      },
    );
  }
 
var _userId;
var authStatus;
void loginCallback() {
    getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = 'LOGGED_IN';
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = 'NOT_LOGGED_IN';
      _userId = "";
    });
  }
}
