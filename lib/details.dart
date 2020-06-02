import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix2;
import 'package:flutter/widgets.dart' as prefix1;
import 'package:path/path.dart' as Path;

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/catimages.dart';
import 'package:firebase_app/catimages.dart' as prefix0;
import 'package:firebase_app/uploadcats.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_app/main.dart';
import 'package:firebase_app/community.dart';
import 'package:firebase_app/camera.dart';

//import 'package:url_launcher/url_launcher.dart';
  const   String topover='Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

class Details extends StatelessWidget {
  final  catname;
  final String catweight;
  final String catlifespan;
  final imageurl;
  final String catimageslink;
  final Color backiconcolor;
  final Color headercolor;
  final Color detailscolor;
  final catid;
  final grooming;
  final health;
  final history;
  final lifespan;
  final overview;
  final personality;
  final facts;
  
  final hygine;
  final intelligence;
  final overallhealth;
  final friendliness;
  final adaptability;
  //var average;
 Details(this.imageurl,this.catname,this.catweight,this.catlifespan,this.catimageslink,this.backiconcolor,this.headercolor,this.detailscolor, this.catid, this.grooming, this.health, this.history, this.lifespan, this.overview, this.personality, this.facts, this.hygine, this.intelligence, this.overallhealth, this.friendliness, this.adaptability);
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 280.0,
                floating: false,
                pinned: true,
                title: null,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                    centerTitle: true,
                    // title: Container(
                    //   color: Colors.black45,
                    //   child:Text(catname,
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 24.0,
                    //     )), ),
                  //titlePadding: EdgeInsets.only(bottom: 45),
                   // title: Text(catname),
                     background: Image.network(
                      imageurl,
                      fit: BoxFit.cover,
                    )),
                   bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      
                    child: 
                        TabBar(
                           indicatorSize: TabBarIndicatorSize.tab,
                          indicator: const BubbleTabIndicator(
                              indicatorHeight: 26.0,
                              indicatorRadius: 12,
                              indicatorColor: Colors.black,
                              tabBarIndicatorSize: TabBarIndicatorSize.tab,),
                            labelColor: Colors.white,
                            labelStyle: TextStyle(fontFamily: 'Futura',fontSize: 14.0,fontWeight: FontWeight.bold),
                            unselectedLabelColor: Colors.grey,
                            unselectedLabelStyle: TextStyle(fontFamily: 'Futura',fontSize: 14.0,fontWeight: FontWeight.bold),
                            isScrollable: true,
                          tabs: [
                                const Tab(
                                    text: 'Overview',
                                    ),
                                const Tab(
                                    text: 'History',
                                    ),
                                const Tab(
                                    text: 'Health',
                                    ),
                                const Tab(
                                    text: 'Personality',
                                    ),
                                const Tab(
                                    text: 'Grooming',
                                    ),
                          ],
                        ),
                     
                         ),)

              ),
              
                
               
                
              
            ];
          },
          body: TabBarView(
                      children: <Widget>[
               Container(
                    color: Colors.white,
                  child: ListView(
                
                scrollDirection: Axis.vertical,
                children:  <Widget>[ 
                  //Headertext2(catname),
                    Padding(
                      padding: const EdgeInsets.only(bottom:20.0,left: 20),
                      child:
                       Text('Name',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:20.0,left: 20,right:20),
                      child:
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: <Widget>[
                           Text(catname,
                      style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                      ) 
                      ),
                          Text('Score '+((adaptability+overallhealth+hygine+friendliness+intelligence)/5).toString()),
                          
                         ],
                       ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(bottom:10.0,left: 20),
                      child:
                       Text('Overview',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),
                   Overview(overview),
                   SizedBox(
                     height: 10,
                   ),
                   Headertext2('Adaptability'),
                   SizedBox(
                     height: 10,
                   ),
                   Progressbar(adaptability*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Overall Health'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(overallhealth*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Hygine'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(hygine*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Friendliness'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(friendliness*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Intelligence'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(intelligence*20),
                     Padding(
                      padding: const EdgeInsets.only(top:20,bottom:20.0,left: 20),
                      child: Text('Facts',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),
                   Overview(facts),
                 ],
                  )
                   
                
              ),
                 Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[ 
                 
                    Padding(
                      padding: const EdgeInsets.only(bottom:20.0,left: 20),
                      child: Text('History',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),Overview(history)
                  
                  
                ],
              ),
              ),
              Container(
                color: Colors.white,
                child: ListView(
                
                children: <Widget>[ 
                   Padding(
                      padding: const EdgeInsets.only(top:0.0,left: 20),
                      child: Text('Lifespan',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(lifespan,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        
                      ) 
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(bottom:20.0,left: 20),
                      child: Text('Health',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),
                    Overview(health),
                   
                   
                  
                  
                ],
              ),
              ),
                Container(
                color: Colors.white,
                child: ListView(
                 
                children: <Widget>[ 
                  
                    Padding(
                      padding: const EdgeInsets.only(bottom:20.0,left: 20),
                      child: Text('Personality',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),Overview(personality)
                  
                  
                ],
              ),
              ),
                 Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[ 
                 
                    Padding(
                      padding: const EdgeInsets.only(bottom:20.0,left: 20),
                      child: Text('Grooming',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26
                      ) 
                      ),
                    ),
                    Overview(grooming)
                  
                  
                ],
              ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(
          child: Icon(Icons.image),
          tooltip: 'more images',
          backgroundColor: Colors.black,
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context)=>MoreImages(catId: catid,catName: catname)
              //UploadUserCats(catID: catid,)
              
            )
            );
            
          },
        ),
      
    );
  }
}

class Simpletexts extends StatelessWidget {
  final String content;
  final FontWeight weight;
  final Color textcolor;
  final double textSIze;
  const Simpletexts(this.content,this.weight,this.textcolor,this.textSIze);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Text(
          content, 
          style: TextStyle(fontFamily: 'Futura',fontSize: textSIze, color: textcolor,fontWeight: weight),
          
          ),
    );
  }
}
class MoreImages extends StatefulWidget {
  final catId;
  final catName;
  const MoreImages({ this.catId, this.catName});
  @override
  _MoreImagesState createState() => _MoreImagesState(catId,catName);
}

class _MoreImagesState extends State<MoreImages> {
  final catId;
  final catName;
  _MoreImagesState(this.catId,this.catName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCutomAvatar(topic:catName.toString(),height:120),

      body: Stack(
        children: <Widget>[
         
            
            Container(
             //height: 300,
             //padding: EdgeInsets.all(20),
             padding: prefix1.EdgeInsets.fromLTRB(0, 0, 0, 0),
             child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Cats').document(catId).collection('cat images')
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
                            scrollDirection: Axis.vertical,
                            children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                                    return new ImageCard(
                                      imageurl: document['Catimageurl'],
                                    );
                            }).toList(),
                          
                          ) ;
                      }
                    },
                  ),
           ),
         
        ],
      ),
          drawer: Sidedrawer(),
    );
  }
}

class ImageCard extends StatelessWidget {
  final imageurl;

  const ImageCard({this.imageurl});
  @override
  Widget build(BuildContext context) {
    return  Container(
        //width:200,
        margin: EdgeInsets.all(20),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
     
        child: Image.network(imageurl,
      //  fit: BoxFit.cover
        
        ),
      ),
    );
  }
}
class Mycat extends StatefulWidget {
  @override
  _MycatState createState() => _MycatState();
}

class _MycatState extends State<Mycat> {
  double initial;

  double distance;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
     body:Center(
       child: const Text('this is your cat'),
     ),
  );
  }
}
class ScrollImagewidget extends StatelessWidget {
  final Color backcolor;
   const ScrollImagewidget(this.backcolor);
  @override
  Widget build(BuildContext context) {
   return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
          child: Container(
          width: 260.0,
          color: backcolor,
          )
      );

  }
}
class PersonalImageCard extends StatelessWidget {
  final imageurl;
  final catname;
  final catage;
  final username;
  final accType;
  final catid;
    const PersonalImageCard({this.imageurl, this.catname, this.catage, this.username, this.catid, this.accType});
  @override
  Widget build(BuildContext context) {
    return  Container(
        //width:200,
        decoration: prefix1.BoxDecoration(
          color: Colors.black,
        borderRadius: BorderRadius.circular(20),


        ),
        margin: EdgeInsets.all(20),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
     
        child: Column(
        children: <Widget>[
          Center(
            child: CachedNetworkImage(imageUrl: imageurl)
          ),
          prefix2.Container(
            padding: prefix1.EdgeInsets.only(top:20,bottom:10,right:20,left:20),
            child: Row(
              mainAxisAlignment: prefix1.MainAxisAlignment.start,
              children: <Widget>[
              Text('Name :    ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white38)),
              Text(catname,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                      color: Colors.white)),
            ],),
          ),
prefix2.Container(
            padding: prefix1.EdgeInsets.only(top:0,bottom:20,right:20,left:20),
            child: Row(
              mainAxisAlignment: prefix1.MainAxisAlignment.spaceBetween,
              mainAxisSize: prefix1.MainAxisSize.max,
              children: <Widget>[
               
             
                       Row(
                         //mainAxisAlignment: prefix1.MainAxisAlignment.spaceBetween,
                         mainAxisSize: prefix1.MainAxisSize.max,
                  children: <Widget>[
                     Text('Age    :    ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white38)),
                      Text(catage,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                      color: Colors.white)),
                    
                  ],
                ),
                  prefix2.Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: accType=='owner'?
                        IconButton(
                          icon: prefix1.Icon(Icons.delete,
                          color:Colors.redAccent
                          ),
                          iconSize: 24, 
                          onPressed:(){
                             showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //positive is 1 
          //negative is 0
          title: Text('Confirm'),
          content:  Text('Are you sure you want to delete '+ catname),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          
            new FlatButton(
              child:new Text('cancel',style: prefix1.TextStyle(color: Colors.blue),),
              onPressed: (){
                Navigator.of(context).pop();
              },
              ),
                new FlatButton(
              child: new Text("Delete",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.red,
              onPressed: () {
                 deletePost(username, catid);
              },
             
            ), 
          ],
        );
      },
    );
                          
                          } ,
                        ):prefix1.Container(
                          height: 24,
                          width: 24,
                        )
                      
                      )
            
            ],),
          )          

        ],
      ),
      ),
    );
  }
 
 
}
 void deletePost(username,catId) async{
     final databaseReference= Firestore.instance;

 // final databaseReferencee = FirebaseDatabase.instance.reference();
  try {
    databaseReference
        .collection('UserCats').document(username!=null?username:'keons').collection('cats').document(catId)
        .delete();
  } catch (e) {
    print(e.toString());
  }
}
class Catpage extends prefix2.StatefulWidget {
  final username;
  final avatar;
  const Catpage({this.username, this.avatar}) ;
  @override
  _CatpageState createState() => _CatpageState(avatar,username: username);
}

class _CatpageState extends prefix2.State<Catpage> {
final username;
final avatar;
//final String user;
//username!=null?final user=username.toString():user='humanss';
  _CatpageState(this.avatar, {this.username});
  @override
  Widget build(BuildContext context) {
      return Scaffold(
       appBar: AppbarCutomAvatar(topic:'My Cats',avatarURL: avatar,height: 120,),
      body: prefix2.Stack(
        children: <prefix2.Widget>[
        
          Center(
            
           child: Container(
             //height: 300,
             //padding: EdgeInsets.all(20),
             padding: prefix1.EdgeInsets.only(top: 1),
             child: StreamBuilder<QuerySnapshot>(
                  stream:  Firestore.instance.collection('UserCats').document(username!=null?username:'keons').collection('cats')
                    .snapshots(),
                  builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return new  ListView(
                            scrollDirection: Axis.vertical,
                            children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                               // Widget body;
                                if(document.exists){
                                  return new PersonalImageCard(
                                    accType: 'owner',
                                    imageurl: document['Maincatimageurl'],
                                    catname: document['cat name'],
                                    catage: document['cat age'],
                                    username: username,
                                    catid: document['catId'],
                                  );
                                }
                                else{
                                  return new Text('empty',
                                style: prefix1.TextStyle(color:Colors.black,
                                fontSize: 40
                                ),
                                );
                                }
                              // return body;
                              
                            }).toList(),
                          );
                      }
                    },
                  ),
           ),
          ),
        ],
      ),
    floatingActionButton: prefix2.Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Add cat',
        style: TextStyle(
          color:Colors.white,
          fontSize: 23
        )
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          prefix1.Navigator.push(context, 
          prefix2.MaterialPageRoute(
            builder: (context)=>UploadUserCats()
          )
          );
        },
      ),
    ), 
    drawer: Sidedrawer(),
    floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,
    );
       

  
 }

//  var username;

//   Future getusername() async{
// final FirebaseUser user=await FirebaseAuth.instance.currentUser();        
//             //signed in
//             String uiD=   user.uid;
//             await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
//               if (datasnapshot.exists) {
//                 setState(() {
//                   //avatarUrl=datasnapshot.data['profile picture'];
//                   username=datasnapshot.data['username'];
//                 });
//                 print (username);
//                 //print (avatarUrl);
//               }
//               else{
//                // print("No such user");
//               }
//               });
          
        
// }
}

class UploadUserCats extends StatefulWidget {
  //final userID;
  
  const UploadUserCats({Key key,}) : super(key: key);
  @override
  _UploadUserCatsState createState() => _UploadUserCatsState();
}

class _UploadUserCatsState extends State<UploadUserCats> {
  //final userID;
File _image;
  String catID;
  String catname;
  var _uploadedFileURL;
   final databaseReference= Firestore.instance;
   prefix1.TextEditingController catN=new prefix1.TextEditingController();
   prefix1.TextEditingController catA=new prefix1.TextEditingController();
  //_UploadUserCatsState(this.userID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: prefix2.AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: prefix2.IconButton(
              icon:Icon(Icons.arrow_back_ios,
              color:Colors.black
              ),
              iconSize: 26,
              onPressed:(){ prefix1.Navigator.pop(context);}
            ),
          ),
          body: Center(
        child:prefix2.ListView(
          children: <prefix2.Widget>[
           _image!=null? Container(
              height: 130,
            ):Container(
              height: 350,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[ 
                _image != null
                                ? Container(
                                  //padding: EdgeInsets.fromLTRB(12, 0, 0, 12.3),
                                 
                                  child:ClipRRect(
                                     borderRadius: BorderRadius.circular(20),
                                    child:Image.file(
                                  _image,
                                  width: 380,
                                 // fit: prefix1.BoxFit.cover,
                                ) ),
                                )
                                : Container(height: 10,
                                width: 302,
                                ),
                Row(
                  mainAxisAlignment: prefix1.MainAxisAlignment.end,
                  children: <Widget>[

                  _image==null? Container():FlatButton(
                  child:Text('remove image',
                  style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                  onPressed: (){
                    clearSelection();
                  },
              ),
              prefix2.Container(
                padding: prefix1.EdgeInsets.all(12),
                child: FlatButton(
                    child:Text('select image',
                    style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    onPressed: (){
                      chooseFile();
                    },
                ),
              )
                ],),
             

                                    
               prefix2.Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: TextFormField(
            //focusNode: myfocusnode1,
            controller: catN,
            maxLines: 1,
            //obscureText: true,
            autofocus: false,
            decoration: new InputDecoration(
                  labelText: 'Cat Name',
                  labelStyle: TextStyle(
                    color:  Colors.grey,
                  ),)),
               ),
                   prefix2.Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: TextFormField(
            //focusNode: myfocusnode1,
            controller: catA,
            maxLines: 1,
       // obscureText: true,
       keyboardType: prefix1.TextInputType.number,
            autofocus: false,
            decoration: new InputDecoration(
                labelText: 'Cat Age (in cat years)',
                labelStyle: TextStyle(
                  color:  Colors.grey,
                ),)),
                   ),
               GestureDetector(
                       child: Container(
                         color: Colors.black,
                      width: prefix1.MediaQuery.of(context).size.width,
                      margin: prefix1.EdgeInsets.all(12),
                      padding: prefix1.EdgeInsets.only(left:20,right:20,top:15,bottom: 15),

                      child:Row(
                        mainAxisAlignment: prefix1.MainAxisAlignment.center,
                        children: <Widget>[
                        Text('Submit',
                    style: TextStyle(color:Colors.white,
                    fontSize: 18
                    ),
                    
                    ),
                      ],) 
                    ),
                    onTap: createpost,
               ), 
            ],),
          ],
        )
         

      ),
          drawer: Sidedrawer(),

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
 
  String username;
  Future getusername() async{
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
   await getusername();
   await uploadPic();

     DocumentReference catId = await databaseReference.collection("UserCats").document(username).collection('cats')
      .add({
        'Maincatimageurl': _uploadedFileURL,
        'cat name': catN.text,
        'cat age': catA.text,
        //'description': details!=null?details:null,
      });
      //add documentID under the username name
      //and the postDocumentIDs under the collection
     catID= catId.documentID; 
      print(catID);
      databaseReference.collection("UserCats").document(username).collection('cats')
        .document( catID)
        .updateData({
          'catId': catID
          });
          catID==null?showtoast('failed'):showtoast('uploaded');
          //cat.clear();
          clearSelection();
          catA.clear();
          catN.clear();

  }
    Future uploadPic() async {    
   StorageReference storageReferences = FirebaseStorage.instance    
       .ref()    
       .child('usercats/${Path.basename(_image.path)}');    
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


class PersonalCatCard {
  final String imageURL;
  final String catAge;
  final String nameOfCat;
  PersonalCatCard({this.imageURL, this.catAge, this.nameOfCat});
  @override
  Widget build(BuildContext context) {
     return  Container(
        //width:200,
        margin: EdgeInsets.all(20),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
     
        child: Image.network(imageURL,
      //  fit: BoxFit.cover
        
        ),
      ),
    );
    // ):  Container(
    //     //width:200,
    //     margin: EdgeInsets.all(20),
    //     child: ClipRRect(
    //   borderRadius: BorderRadius.circular(20),
     
    //     child: Image.network(imageURL,
    //   //  fit: BoxFit.cover
        
    //     ),
    //   ),
    // );
    // return Image.network(imageURL,
    //        // fit: prefix1.BoxFit.cover
    //         );
  //   return Container(
  //     // width: 300,
  //      height: 450,
  //     decoration: prefix1.BoxDecoration(
  //       borderRadius: prefix1.BorderRadius.circular(20),

  //     ),
  //     child:prefix1.Stack(
  //       children: <Widget>[
  //         Align(
  //           alignment: Alignment.center,
  //           child: prefix1.Image.network(imageURL,
  //           fit: prefix1.BoxFit.cover
  //           ),
  //         ),
  //         Align(alignment: Alignment.center,
  //         child: Container(
  //           // width: 300,
  //           // height: 150,
  //           decoration: prefix1.BoxDecoration(
  //             borderRadius: prefix1.BorderRadius.circular(20),
  //             color: Colors.black38
  //           ),
  //         ),
  //         ),
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child:Row(children: <Widget>[
  //             prefix1.Text(nameOfCat),
  //             Text(catAge),
  //           ],)
  //         )
  //       ],
  //     )
  //   );
  // }
  }
}
class Scaftest extends StatelessWidget {
    final catimage;
  final catname;
  final catid;
  final grooming;
  final health;
  final history;
  final lifespan;
  final overview;
  final personality;
  final facts;
  
  final hygine;
  final intelligence;
  final overallhealth;
  final friendliness;
  final adaptability;

  const Scaftest({Key key, this.catimage, this.catname, this.catid, this.grooming, this.health, this.history, this.lifespan, this.overview, this.personality, this.hygine, this.intelligence, this.overallhealth, this.friendliness, this.adaptability, this.facts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
return MaterialApp(
            debugShowCheckedModeBanner:false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar:  TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BubbleTabIndicator(
                indicatorHeight: 26.0,
                indicatorRadius: 12,
                indicatorColor: Colors.black,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,),
              labelColor: Colors.white,
              labelStyle: TextStyle(fontFamily: 'Futura',fontSize: 14.0,fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontFamily: 'Futura',fontSize: 14.0,fontWeight: FontWeight.bold),
              isScrollable: true,
              tabs:[
            const Tab(
                text: 'Overview',
                 ),
            const Tab(
                text: 'History',
                 ),
            const Tab(
                text: 'Health',
                 ),
            const Tab(
                text: 'Personality',
                 ),
            const Tab(
                text: 'Grooming',
                 ),
          ],
            ),
          
          body: TabBarView(
                      children: <Widget>[
               Container(
                    
                  child: ListView(
                
                scrollDirection: Axis.vertical,
                children:  <Widget>[ 
                  //Headertext2(catname),
                 
                   Overview(overview),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Adaptability'),
                   SizedBox(
                     height: 10,
                   ),
                   Progressbar(adaptability*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Overall Health'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(overallhealth*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Hygine'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(hygine*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Friendliness'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(friendliness*20),
                   SizedBox(
                     height: 20,
                   ),
                   Headertext2('Intelligence'),
                    SizedBox(
                     height: 10,
                   ),
                   Progressbar(intelligence*20),
                   Headertext2('Facts'),
                   Overview(facts),
                 ],
                  )
                   
                
              ),
               Wrap(
                children:  <Widget>[
                  Overview(history),
                ],
              ),
               Wrap(
                children: <Widget>[ 
                  Overview(health)
                ],
              ),
               Wrap(
                children:<Widget>[ 
                  Overview(personality)
                ],
              ),
               Wrap(
                children:<Widget>[ 
                  Overview(grooming)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class Progressbar extends StatelessWidget {
  final int value;
  const Progressbar(this.value);
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,0),
          child: FAProgressBar(
      currentValue: value,
      size: 4,
      borderRadius: 10,
      
      backgroundColor: Colors.black12,
      progressColor: value>=80?Colors.green[200]:value>=50 && value<80?Colors.yellow[200]:value<50 && value>=25?Colors.orange[200]:Colors.red[200],
      animatedDuration: const Duration(milliseconds:2000),
      direction: Axis.horizontal,
    ),
        )),
    );
  }
}
 class Headertext2 extends StatelessWidget {
  final String namee;
   Headertext2(this.namee);
   @override
   Widget build(BuildContext context) {
     return  Container(
          margin:  EdgeInsets.fromLTRB(20.0,0.0,0.0,0.0),
            child: Align(
            alignment: Alignment.topLeft,
              child:Text(namee,
                style: TextStyle(fontSize: 21,fontFamily: 'Futura', fontWeight: FontWeight.bold,color: Colors.black),
              )
            )
          );
   }
 }