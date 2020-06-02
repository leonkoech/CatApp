import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/uploadcats.dart';
import 'package:firebase_auth/firebase_auth.dart' as prefix2;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as prefix1;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_app/community.dart';
import 'package:firebase_app/details.dart';
import 'package:firebase_app/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'about.dart';
import 'loginsignup.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Cat App Demo',
theme: ThemeData(
// Define the default brightness and colors.
brightness: Brightness.light,
primaryColor: Colors.black,
accentColor: Colors.transparent,
// Define the default font family.
fontFamily: 'Futura',
// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
textTheme: const TextTheme(
headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
title: TextStyle(fontSize: 32.0, fontStyle: FontStyle.normal),
body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
),
),
home: MyHomePage(),
);
}
}

class MyHomePage extends StatefulWidget {
MyHomePage({Key key}) : super(key: key);

@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
                // Obtain a list of the available cameras on the device.
  var imageurl;
  var catnames;
  var catType;
  Widget catcard;
   String topover='Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
    body:Stack(
      fit: prefix1.StackFit.expand,
      children: <Widget>[
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
         Appbarcustom(topic: 'home',),
          SizedBox(
            child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          "Cats",
                          style:  TextStyle(color: Colors.black, fontSize: 52,fontWeight: FontWeight.bold,letterSpacing: 2.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(4.0,2.0,2.0,10.0),
                        child: Text(
                          "(our liquid-ish friends)",
                           style:  TextStyle(color: Colors.black26, fontSize: 18,fontWeight: FontWeight.w300),

                        ),
                      ),
                    ),
                  ],
                ),
            height: 50.0,
          ),
          Flexible(
              child:  DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar:  TabBar(
                         indicatorColor: Colors.blue,
                      indicatorPadding: prefix0.EdgeInsets.fromLTRB(10, 0, 10, 12),
                      indicatorWeight: 2,
                        labelColor: Colors.blue,
                        labelStyle: const TextStyle(fontFamily: 'Futura',fontSize: 16.0,fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black26,
                        unselectedLabelStyle: const TextStyle(fontFamily: 'Futura',fontSize: 16.0,fontWeight: FontWeight.bold),
                        isScrollable: true,
                        tabs:[
                      const Tab(
                          text: 'Top',
                           ),
                      const Tab(
                          text: 'Long-haired',
                           ),
                      const Tab(
                          text: 'Short-haired',
                           ),
                      
                    ],
                      ),
                    
                    body: TabBarView(
                                children: <Widget>[
                          ListView(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                Container(
                                margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,20.0),
                                child:  SizedBox(
                                    height: 235,
                                    child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,20.0),
                                    child:StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Cats')
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
                                scrollDirection: Axis.horizontal,
                                children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                    if(snapshot.data.documents!=null){
                                      imageurl=document['Catimageurl'];
                                      catnames=document['catname'];
                                    if(catnames=='Himalayan'|| catnames=='Birman' || catnames=='American short hair' || catnames=='Ragdoll' || catnames=='British short hair'){
                                    catcard= new Imagemain(
                                      catimage: imageurl,
                                      catname: catnames,
                                      catid: document['CatId'],
                                      adaptability: document['adaptability'],
                                      friendliness: document['friendliness'],
                                      grooming:  document['grooming'],
                                      health: document['health'],
                                      history: document['history'],
                                      hygine: document['hygine'],
                                      intelligence: document['intelligence'],
                                      lifespan: document['lifespan'],
                                      overallhealth: document['overallHealth'],
                                      overview: document['overview'],
                                      personality: document['personality'],
                                      facts: document['facts']
                                    );

                                    }
                                    else{
                                      catcard=Container();
                                    }
                                    return catcard;
                                    }
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
                                ),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:<Widget>[
                                            Row(
                                                   children: <Widget>[
                                                     Padding(
                                                        padding: const EdgeInsets.only(bottom:20.0,left: 20),
                                                        child: Text('Overview',
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black26
                                                        ) 
                                                        ),
                                                      ),
                                                   ],
                                                 ),
                                          Overview("Here's a list of the top cat breeds.\nThese cat breeds are the cream of the crop when it comes to cat breeds, and this list can be used as a tool for potential cat slaves (no one owns a cat).\nAnd remeber kids, you can always adopt one of these furry creatures."),
                                      ]
                                    ), 
                        ]),
                            ],
                          ),
  
                                   
                                   prefix1.ListView(
                                     children: <Widget>[
                                       Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            Container(
                            margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,20.0),
                            child:  SizedBox(
                                          height: 235,
                                          child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,20.0),
                                          child:StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Cats')
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
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data.documents
                                        .map((DocumentSnapshot document) {
                                          if(snapshot.data.documents!=null){
                                            catType=document['type'];
                                            if(catType=='long-haired'){
                                              catcard= new Imagemain(
                                            catimage: document['Catimageurl'],
                                            catname: document['catname'],
                                            catid: document['CatId'],
                                  adaptability: document['adaptability'],
                                  friendliness: document['friendliness'],
                                  grooming:  document['grooming'],
                                  health: document['health'],
                                  history: document['history'],
                                  hygine: document['hygine'],
                                  intelligence: document['intelligence'],
                                  lifespan: document['lifespan'],
                                  overallhealth: document['overallHealth'],
                                  overview: document['overview'],
                                  personality: document['personality'],
                                  facts: document['facts']

                                          );
                                            }
                                            else{
                                              catcard=Container();
                                            }
                                          return  catcard;
                                          }
                                          else{
                                            return new Text('empty');
                                          }
                            }).toList(),
                          );
                      }
                    
                      
                    },
                )),
                                          ),
                            ),
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:<Widget>[
                                                 Row(
                                                   children: <Widget>[
                                                     Padding(
                                                        padding: const EdgeInsets.only(bottom:20.0,left: 20),
                                                        child: Text('Overview',
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black26
                                                        ) 
                                                        ),
                                                      ),
                                                   ],
                                                 ),
                                                Overview("If you want a soft, fluffy cat, you’ll probably find what you’re looking for with a longhaired cat breed. These felines have long and luxurious coats that are silky to the touch. Despite their softness and beauty, longhaired cats may not be right for everyone. They require daily grooming to keep their coats tangle- and mat-free, which can be a chore for busy individuals or families. Plus, they may trigger an allergic reaction in people with dander allergies, which is exacerbated by the frequent shedding. "),
                                            ]
                                          ),
                        ]
                       
                       
                               ),
                                     ],
                                   ),
                             

                              ListView(
                                children: <Widget>[
                                  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            Container(
                            margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,20.0),
                            child:  SizedBox(
                                    height: 235,
                                    child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,20.0),
                                    child:StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('Cats')
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
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                    if(snapshot.data.documents!=null){
                                      catType=document['type'];
                                      if(catType=='short-haired'){
                                        catcard= new Imagemain(
                                      catimage: document['Catimageurl'],
                                      catname: document['catname'],
                                      catid: document['CatId'],
                                      adaptability: document['adaptability'],
                                      friendliness: document['friendliness'],
                                      grooming:  document['grooming'],
                                      health: document['health'],
                                      history: document['history'],
                                      hygine: document['hygine'],
                                      intelligence: document['intelligence'],
                                      lifespan: document['lifespan'],
                                      overallhealth: document['overallHealth'],
                                      overview: document['overview'],
                                      personality: document['personality'],
                                      facts: document['facts']

                                    );
                                      }
                                      else{
                                        catcard=Container();
                                      }
                                    return  catcard;
                                    }
                                    else{
                                      return new Text('empty');
                                    }
                            }).toList(),
                          );
                      }
                    
                      
                    },
                )),
                                    ),
                            ),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:<Widget>[
                                            Row(
                                                   children: <Widget>[
                                                     Padding(
                                                        padding: const EdgeInsets.only(bottom:20.0,left: 20),
                                                        child: Text('Overview',
                                                        style: TextStyle(
                                                          fontSize: 26,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black26
                                                        ) 
                                                        ),
                                                      ),
                                                   ],
                                                 ),
                                          Overview("If you want a low-maintenance feline, a shorthaired cat may be the perfect fit. Because their coats are short, they don’t require daily grooming like longhaired cat breeds. Instead, periodic brushing is all they need to keep their coats healthy and to reduce shedding. If that sounds like the perfect match for your busy lifestyle, explore our list of shorthaired cat breeds below. "),
                                      ]
                                    ),
                        ]),
                                ],
                              ),

                          ],
                ),
              ),
          ),
        
            
          )
        
   ]),
      ],
    ),
        
    

    drawer: Sidedrawer(),
    );
  }
}
class AppbarCutomAvatar extends StatelessWidget implements PreferredSizeWidget {
  final topic;
  final avatarURL;
    final double height;

   AppbarCutomAvatar({this.topic, this.avatarURL, this.height});

  @override
  Widget build(BuildContext context) {
     return  Padding(
       padding: prefix1.EdgeInsets.only(left: 10,right: 10),
            child: Container( 
              height: 79,
              width:MediaQuery.of(context).size.width-10,
              margin: prefix1.EdgeInsets.fromLTRB(0, 24, 0, 0),
              padding: prefix1.EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: prefix1.BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
              new BoxShadow(
                color: Colors.black54,
                offset: new Offset(5.0, 9.0),
                blurRadius: 30.0,
              )
            ],
                 borderRadius: prefix1.BorderRadius.circular(12) 
                 
              ),
              child:Row(
                mainAxisAlignment: prefix1.MainAxisAlignment.spaceBetween,
                children: <Widget>[
                IconButton(
                    iconSize: 26,
                    icon: prefix1.Icon(Icons.sort,
                    color:Colors.white
                    ),
                    onPressed: (){
                      Scaffold.of(context).openDrawer();
                    },
                              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,

                  ),
                  Container(
                    alignment: prefix1.Alignment.center,
                    child:Text(topic,
                  style: prefix1.TextStyle(color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                  ),
                  )
                  ),
                  Container(
                   // width: 26,
                   padding: prefix1.EdgeInsets.all(10),
                    //color: Colors.white,
                    child: prefix1.ClipRRect(
                      borderRadius: prefix1.BorderRadius.circular(30),
                     //child: avatarURL!=null?Image.network(avatarURL):Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSYa_UviZTqw9XnbUGVfztzXaB-yd7ap5hBZA7yEE7RVnLR3pEF')
                      child: FutureBuilder<Widget>(
                          future: getImage(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data;
                            } else {
                              return Text(' ');
                            }
                          },
                        ),
                    ),
                  )
                  
              ],)
            ),
     );
  }
   var avatarUrl;
     Future<Widget> getImage() async {
       //await getavatar();
    final Completer<Widget> completer = Completer();

    final url = avatarURL==null?"https://www.publicdomainpictures.net/pictures/200000/velka/plain-black-background.jpg":avatarURL;
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(
        prefix0.ClipRRect(
          borderRadius: prefix0.BorderRadius.circular(30),
          child: Image(image: image),
        )
        );
    });

    load.addListener(listener);
    return completer.future;
  }

 
   @override
  Size get preferredSize => Size.fromHeight(height);
          
        
}


class Appbarcustom extends StatelessWidget {
  final String topic;
  //final context;
  Appbarcustom({@required this.topic});
  @override
  Widget build(BuildContext context) {
    return  Container( 
            height: 79,
            width:MediaQuery.of(context).size.width-30,
            margin: prefix1.EdgeInsets.fromLTRB(0, 24, 0, 30),
            padding: prefix1.EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: prefix1.BoxDecoration(
                color: Colors.black,
                boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              offset: new Offset(5.0, 9.0),
              blurRadius: 30.0,
            )
          ],
               borderRadius: prefix1.BorderRadius.circular(12)
               
            ),
            child:Row(
              mainAxisAlignment: prefix1.MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 26,
                  icon: prefix1.Icon(Icons.sort,
                  color:Colors.white
                  ),
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,

                ),
                Container(
                  alignment: prefix1.Alignment.center,
                  child:Text(topic,
                style: prefix1.TextStyle(color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
                ),
                )
                ),
                Container(
                  width: 26,
                )
                
            ],)
          );
  }
}
class Sidedrawer extends StatefulWidget {
  @override
  _SidedrawerState createState() => _SidedrawerState();
}

class _SidedrawerState extends State<Sidedrawer> {
     final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
var username;
  @override
  Widget build(BuildContext context) {
    return  Drawer(
    child: 
        Container(
          color:Colors.black,
          child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute<Navigator>(builder: (context) => MyHomePage()),
              );
            },
            child: const Sidelist('Home'),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute<Navigator>(builder: (context) => Camerascreen()),
              );
            },
            child:const Sidelist('Cat-cam'),
          ),
          GestureDetector(
 
            onTap: ()async {
               FirebaseAuth.instance.currentUser().then((firebaseUser) async{
              if(firebaseUser == null)
              {
                //signed out
                _showDialog(context);
                
              }
              else{
                //signed in
                //String uiD=user.uid;
                FirebaseUser user=await FirebaseAuth.instance.currentUser();    
                String uiD=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
              if (datasnapshot.exists) {
                  String usernameD;
                  var avatarUrl;
                  //avatarUrl=datasnapshot.data['profile picture'];
                  usernameD=datasnapshot.data['username'];
                  avatarUrl=datasnapshot.data['profile picture'];
                print (usernameD);
                print(avatarUrl);
                 Navigator.push(
                context,
                MaterialPageRoute<Navigator>(builder: (context) => Catpage(username: usernameD, avatar: avatarUrl,),)
              );
                //print (avatarUrl);
              }
              else{
               // print("No such user");
              }
              });
               
              }
              return firebaseUser;
            });
            
            },
            child: const Sidelist('My Cats'),
          ),
          GestureDetector(
            onTap: ()  {
                FirebaseAuth.instance.currentUser().then((firebaseUser) async{
              if(firebaseUser == null)
              {
                //signed out
                _showDialog(context);
                
              }
              else{
                //signed in
                //String uiD=user.uid;
                    FirebaseUser user=await FirebaseAuth.instance.currentUser();    
                String uiD=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
              if (datasnapshot.exists) {
                  String usernameD;
                  var avatarUrl;
                  //avatarUrl=datasnapshot.data['profile picture'];
                  usernameD=datasnapshot.data['username'];
                  avatarUrl=datasnapshot.data['profile picture'];
                print(usernameD);
                print(avatarUrl);
                Navigator.push(
                context,
                MaterialPageRoute<Navigator>(builder: (context) => Community(usernameID:uiD,username:usernameD,avatarUrl:avatarUrl)),
              );
              }
              //return firebaseUser;
            });
            
            }
                });
                },
            child: const Sidelist('Community'),
          ),

            GestureDetector(
            onTap: (
          ) {
            FirebaseAuth.instance.currentUser().then((firebaseUser) async{
              if(firebaseUser == null)
              {
                //signed out
                _showDialog(context);
                
              }
              else{
                //signed in
              FirebaseUser user=await FirebaseAuth.instance.currentUser();    
                String uiD=   user.uid;
            await Firestore.instance.collection("UserAccounts").document(uiD).get().then((datasnapshot) {
              if (datasnapshot.exists) {
                  String usernameD;
                  String avatarUrl;
                  String preferredName;
                  String dob;
                  String email;
                  //avatarUrl=datasnapshot.data['profile picture'];
                  usernameD=datasnapshot.data['username'];
                  avatarUrl=datasnapshot.data['profile picture'];
                  preferredName=datasnapshot.data['preferred names'];
                  dob=datasnapshot.data['date of birth'];
                  email=datasnapshot.data['email'];
                  preferredName!=null?preferredName=preferredName:preferredName=usernameD;
                  dob!=null?dob=dob:dob='MM/DD/YYYY';
                  
                print(usernameD);
                print(avatarUrl);
                print(dob);
                print(email);
                Navigator.push(
                context,
                MaterialPageRoute<Navigator>(builder: (context) => Profile(type:'my cat',username: usernameD,avatarUrl: avatarUrl,preferredName: preferredName ,dateOfBirth: dob,userId: uiD,email: email,)),
              );
              }
              //return firebaseUser;
            });
              }
            });
 
      },
            child: const Sidelist('Profile'),
          ),
           GestureDetector(
            onTap: null,
            child: const Sidelist('About'),
          ),
           GestureDetector(
            onTap: (){
             FirebaseAuth.instance.currentUser().then((firebaseUser) async{
              if(firebaseUser == null)
              {
                //signed out
                _showDialog(context);
                
              }
              else{
                //signed in
                _showDialogsignout(context);
              }
            });
            },
            child:  Sign(),
          )
      ],
    
  ),
        ));
  }
  String text;
  Future textout() async{
    prefix1.GestureDetector meeow;
     await FirebaseAuth.instance.currentUser().then((firebaseUser){
            if(firebaseUser == null)
            {
              //signed out
              meeow=  GestureDetector(
                    onTap: (){
                      _showDialog(context);
                    },
                    child:  Sidelist('Sign in'),
                  
                  );
              setState((){
                text='Sign In';
          });
            }
            else{
              //signed in
               meeow=GestureDetector(
                    onTap: (){
                      _showDialogsignout(context);
                    },
                    child:  Sidelist('Sign out'),
                  );
          }
          setState((){
            text='Sign Out';
          });
          
          });
          return meeow;
  }
    void _showDialogsignout(BuildContext context) {
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
          title: Text('Sign Out'),
          content:  Text('Are you sure you want to Sign Out?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          
            new FlatButton(
              child:new Text('cancel',style: prefix1.TextStyle(color: Colors.blue),),
              onPressed: (){
                Navigator.of(context).pop();
              },
              ),
                new FlatButton(
              child: new Text("sign out",
              style:  TextStyle(color: Colors.white),
              ),
              //autofocus: true,
              color: Colors.red,
              onPressed: () {
              
            FirebaseAuth.instance.currentUser().then((firebaseUser){
              if(firebaseUser == null)
              {
                //signed out
                Fluttertoast.showToast(
                    msg: "No account found",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                
              }
              else{
                _firebaseAuth.signOut();
                  Fluttertoast.showToast(
                    msg: "Successfully Signed out",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.pop(context);
              }
            });
              },
             
            ), 
          ],
        );
      },
    );
  }
  

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
              child:new Text('go back',style: prefix1.TextStyle(color: Colors.blue),),
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
   
}
class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  
  var userID;
  Widget text;
  //_SignState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsername();
  }
  @override
  Widget build(BuildContext context) {
    userID==null?text=Sidelist('Sign in'):text=Sidelist('Sign out');
    return text;
  }
  fetchUsername(){
      FirebaseAuth.instance.currentUser().then((firebaseUser) async{
              if(firebaseUser == null)
              {
                //signed out
                //_showDialog(context);
                setState(() {
                  userID=null;
                });
                
              }
              else{
                //signed in
              FirebaseUser user=await FirebaseAuth.instance.currentUser();  
              setState(() {
                 userID= user.uid;
              });  
              
              }
            });
  }
}
class Sidelist extends StatelessWidget {
  final String details;
   const Sidelist(this.details);
  @override
  Widget build(BuildContext context) {
    return Container(
  margin:const EdgeInsets.only(top: 20.0),
    child:ListTile(
      title: Text(details,
        style: const TextStyle(fontFamily: 'Futura',fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.white),
      ),
    )
  );
}}
class Imagemain extends StatelessWidget {
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
  const Imagemain({Key key, this.catimage, this.catname, this.catid, this.grooming, this.health, this.history, this.lifespan, this.overview, this.personality, this.hygine, this.intelligence, this.overallhealth, this.friendliness, this.adaptability, this.facts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
 // height: 150.0,
  
         
    child: Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
        child: Container(
            color: Colors.black,
          child: Container(
            
            child: catimage!=null?GestureDetector(
              child: prefix1.Column(
                ///direction: prefix1.Axis.vertical,
                
                children:<Widget>[
                  Container(
                    height: 150,
                    child: GestureDetector(
                         child: Align(
                        alignment: Alignment.center,
                        child: Image.network(catimage),
                      ),
                    ),
                  ),
                  prefix1.SizedBox(
                      height: 5,
                  ),
                 Text(catname,
                    style: TextStyle(fontSize: 26.0,fontFamily: 'Futura', fontWeight: FontWeight.bold,color: Colors.white),
                  )
                ] 
              ),
              onTap: (){
                prefix1.Navigator.push(context, MaterialPageRoute(
                  builder:(context)=>  Details(catimage,catname,'20kg',lifespan,'yellow',Colors.black,Colors.black,Colors.blue,
                   catid,grooming,health,history,lifespan,overview,personality,facts,hygine,intelligence,overallhealth,friendliness,adaptability
                  )

                ));
              },
            ):
                  Container()
                ,
            
          ),
        ),
      ),
    ),
  );
  }
}
class Imagewidget extends StatelessWidget {
  final String color;
  final Color backcolor;
  final Color tcolor;
   const Imagewidget(this.color,this.backcolor,this.tcolor);
  @override
  Widget build(BuildContext context) {
   return Container(
  width: 260.0,
    child: Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
          child: Container(
          width: 240.0,
          color: backcolor,
            child: Align(
            alignment: const Alignment(-0.50,0.89),
              child:Text(color,
                style: TextStyle(fontSize: 23.0,fontFamily: 'Futura', fontWeight: FontWeight.bold,color: tcolor,letterSpacing: 3.0),
              )
            )
          )
        ),
      ),
    ),
  );
  }
}
class Overview extends StatelessWidget {
  final String catoverview;
   const Overview(this.catoverview);
  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.only(right: 20.0,left: 20.0),
    alignment: Alignment.topLeft,
      child:Text(catoverview,
        style: const TextStyle(fontSize: 21,fontFamily: 'Futura', fontWeight: FontWeight.normal,color: Colors.black),
      )
    );
}}
class Headtexts extends StatelessWidget {
  final String name;
  final double f;
   const Headtexts(this.name,this.f);
  @override
  Widget build(BuildContext context) {
    return Container(
  margin: const EdgeInsets.fromLTRB(20.0,10.0,0.0,20.0),
    child: Align(
    alignment: Alignment.topLeft,
      child:Text(name,
        style: TextStyle(fontSize: f,fontFamily: 'Futura', fontWeight: FontWeight.bold,color: Colors.black),
      )
    )
  );
}}
