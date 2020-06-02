import 'dart:async';
import 'dart:io';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'community.dart';
import 'details.dart';

class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
//loads user profile
class Profile extends StatefulWidget {
    final username;
  final avatarUrl;
  final email;
  final userId;
  final preferredName;
  final bio;
  final dateOfBirth;
  final type;
  const Profile({Key key,this.type, this.username, this.avatarUrl,  this.bio, this.preferredName, this.dateOfBirth, this.email, this.userId,}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState(type,username,avatarUrl,preferredName,bio,dateOfBirth,email,userId);
}

class _ProfileState extends State<Profile> {
   final username;
  final avatarUrl;
  final email;
  final userId;
  final preferredName;
  final bio;
  final dateOfBirth;
  final type;
  _ProfileState(this.type,this.username, this.avatarUrl, this.bio, this.preferredName, this.dateOfBirth, this.email, this.userId,);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     // appBar: AppbarCutomAvatar(type.toString(),),
     appBar: null,
     body: body(),
     drawer: Sidedrawer(),
    );
  }
  Widget body(){
         return Scaffold(
          backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 220.0,
                floating: false,
                pinned: true,
                title: null,
                backgroundColor: Colors.white,
       leading: type!='my cat'?IconButton(
         icon: Icon(Icons.arrow_back,
         color: Colors.black,
         ),
         iconSize: 26,
         onPressed: (){Navigator.pop(context);
         }):IconButton(
           icon: Icon(Icons.sort,color: Colors.black,
         ),
         iconSize: 26,
         tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
         onPressed: (){
           Scaffold.of(context).openDrawer();
         }
           
         ),
         //when type is set to 'my cat' it means it is a personal account
         //only personal users can see the 'edit profile' button
         actions:
          type=='my cat'? <Widget>[
           prefix0.Container(
             padding: const EdgeInsets.all(8.0),
             decoration: prefix0.BoxDecoration(
               borderRadius: prefix0.BorderRadius.circular(12) 
             ),
             child: FlatButton(
               
               color: Colors.black,
               child: 

               Text(
                 'edit profile',
                  style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  ),
               ),
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context)=>EditProfile(accountUsername: username,accountEmail: email,accountBio: bio,accountDOB: dateOfBirth,accountPreferredName: preferredName,userId: userId,avatarurl: avatarUrl,)
                 ));
               },
             ),
           )
         ]:null,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                    centerTitle: true,
                 
                     background:prefix0.Container(
                       padding: prefix0.EdgeInsets.fromLTRB(20, 50, 10, 20),
                       child: Row(
                        // mainAxisAlignment: prefix0.MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                        Container(
                          width: 180,
                          child: FutureBuilder<Widget>(
                           future: getImage(),
                           builder: (context, snapshot) {
                             if (snapshot.hasData) {
                               return snapshot.data;
                             } else {
                               return Text(' ');
                             }
                           },
                         ) ,
                        ),
                         prefix0.Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: prefix0.MainAxisAlignment.center,
                             children: <Widget>[
                               Text('@'+username,
                                   style:TextStyle(color: Colors.black,
                                       fontWeight: FontWeight.normal,
                                       fontSize: 18
                                   )
                               ),
                               prefix0.Wrap(
                                 children:<Widget>[ Text('preferred',
                                     style:TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold,
                                         fontSize: 23
                                     )
                                 ),]
                               ),
                               prefix0.Padding(
                                 padding: const EdgeInsets.only(top:8.0),
                                 child: Wrap(
                                   children: <Widget>[
                                     Text(bio,
                                         style:TextStyle(color: Colors.black,
                                             fontWeight: FontWeight.normal,
                                             fontSize: 23
                                         )
                                     ),
                                   ],
                                 ),
                               )
                             ],
                           ),
                         ),

                       ],
                   ),
                     )
                    ),
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
                                    text: 'Cats',
                                    ),
                                const Tab(
                                    text: 'Posts',
                                    ),
                                
                          ],
                        ),
                     
                         ),)

              ),
              
                
               
                
              
            ];
          },
          body:   TabBarView(
                         children: <Widget>[
                           prefix0.Padding(
                             padding: const EdgeInsets.all(8.0),
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
                                               //scrollDirection: Axis.horizontal,
                                               children: snapshot.data.documents
                                                   .map((DocumentSnapshot document) {
                                                 // Widget body;
                                                 if(document.exists){
                                                   return new Container(
                                                     width: 200,
                                                     child: PersonalCatImageCard(
                                                       accType: type=='my cat'?['owner']:['visitor'],
                                                       imageurl: document['Maincatimageurl'],
                                                       catname: document['cat name'],
                                                       catage: document['cat age'],
                                                       username: username,
                                                       catid: document['catId'],
                                                     ),
                                                   );
                                                 }
                                                 else{
                                                   return new Text('empty',
                                                     style: TextStyle(color:Colors.black,
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
                                prefix0.Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                           scrollDirection: Axis.vertical,
                                           shrinkWrap: true,
                                           children: snapshot.data.documents
                                               .map((DocumentSnapshot document) {
                                             if(snapshot.data.documents!=null){
                                               Widget bleh;
                                               username==document['username']?bleh=CustomCard(
                                                 username: document['username'],
                                                 description: document['description'],
                                                 datePosted: document['date'],
                                                 timePosted: document['time'],
                                                 imageUrl: document['imageurl'],
                                                 postID: document['postId'],
                                                 nooflikes: document['likes'],
                                               ):bleh=Container();
                                               return bleh;
                                               }
                                             else{
                                               return new Text('empty');
                                             }
                                           }).toList(),
                                         );
                                     }


                                   },
                               ),
                                )
                         ],
                       )
               
        
        ),
      ),
   
      
    ); 
  }
       Future<Widget> getImage() async {
       //await getavatar();
    final Completer<Widget> completer = Completer();

    final url = avatarUrl==null?"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSYa_UviZTqw9XnbUGVfztzXaB-yd7ap5hBZA7yEE7RVnLR3pEF":avatarUrl;
    final image = NetworkImage(url);
    final config = await image.obtainKey(const ImageConfiguration());
    final load = image.load(config);

    final listener = new ImageStreamListener((ImageInfo info, isSync) async {
        completer.complete(
        prefix0.Container(
          
          width: 70,
          //height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image(image: image,
            fit: prefix0.BoxFit.fitWidth,
            ),
          ),
        )
        );
    });

    load.addListener(listener);
    return completer.future;
  }
}
class PersonalCatImageCard extends StatelessWidget {
  final imageurl;
  final catname;
  final catage;
  final username;
  final accType;
  final catid;
    const PersonalCatImageCard({this.imageurl, this.catname, this.catage, this.username, this.catid, this.accType});
  @override
  Widget build(BuildContext context) {
    return  Container(
      
        //width:200,
        decoration: BoxDecoration(
          color: Colors.black,
        borderRadius: BorderRadius.circular(20),


        ),
        margin: EdgeInsets.all(10),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
     
        child: Column(
        children: <Widget>[
          Center(
            child: CachedNetworkImage(imageUrl: imageurl)
          ),
          Container(
            padding: EdgeInsets.only(top:20,bottom:10,right:20,left:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Text('Name :    ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.white38)),
              Text(catname,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                      color: Colors.white)),
            ],),
          ),
Container(
            padding: EdgeInsets.only(top:0,bottom:0,right:20,left:20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
               
             
                       Row(
                         //mainAxisAlignment: prefix1.MainAxisAlignment.spaceBetween,
                         mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                     Text('Age    :    ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.white38)),
                      Text(catage,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                      color: Colors.white)),
                    
                  ],
                ),
                  Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: accType=='owner'?
                        IconButton(
                          icon: Icon(Icons.delete,
                          color:Colors.redAccent
                          ),
                          iconSize: 14, 
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
              child:new Text('cancel',style: TextStyle(color: Colors.blue),),
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
                        ):Container(
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
 
//class for editing profile
class EditProfile extends StatefulWidget {
   final accountUsername;
    final accountPreferredName;
    final accountBio;
    final accountDOB;
    final accountEmail;
    final userId;
    final avatarurl;
  const EditProfile({prefix0.Key key, this.accountUsername, this.accountPreferredName, this.accountBio, this.accountDOB, this.accountEmail, this.userId, this.avatarurl}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState(accountUsername,accountPreferredName,accountBio,accountDOB,accountEmail,userId,avatarurl);
}

class _EditProfileState extends State<EditProfile> {
   final accountUsername;
    final accountPreferredName;
    final accountBio;
    final accountDOB;
    final accountEmail;
    final userId;
    final avatarUrl;
    
   File profileimage;
     TextEditingController bioController,preferredNameController,emailController,
      dobController,usernameController;
    final databaseReference= Firestore.instance;

  var profileurl;
    @override
  void initState() {
    super.initState();
  profileimage=null;
  }

  _EditProfileState(this.accountUsername, this.accountPreferredName, this.accountBio, this.accountDOB, this.accountEmail, this.userId, this.avatarUrl); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCutomAvatar(topic:'Edit Profile',avatarURL: 'https://www.publicdomainpictures.net/pictures/200000/velka/plain-black-background.jpg',height: 105,),
      body:Padding(
        padding: EdgeInsets.only(top: 105,right: 20,left:20),
        child: ListView(
          children:<Widget>[
          Row(
            children: <Widget>[
                 GestureDetector(
            
            child: profileimage==null?Container(
              
          // height: 80,
           decoration: new BoxDecoration(
              color: Colors.transparent,
            ),
             height: 100,
             padding: EdgeInsets.fromLTRB(0,0, 0, 0),
              child:
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: avatarUrl!=null?Container(
                      decoration: prefix0.BoxDecoration(
                        borderRadius: prefix0.BorderRadius.circular(120)
                      ),
                      height:100,
                      width: 100,
                      child: Image.network(avatarUrl,
                      fit:BoxFit.cover,
                      ),
                    ):Ink(
                      decoration: ShapeDecoration(
                        color: Colors.black26,
                        shape: CircleBorder(),
                      ),
                      child:IconButton(
                            iconSize: 80,
                            icon: Icon(Icons.person,
                            color: Colors.black12,),
                            onPressed: null,
                          
                          )
                      )
                  ),
                 
                  Align(
                    alignment: Alignment(-1,1),
                  child: GestureDetector(
                    child: Icon(
                      
                      Icons.add_a_photo,
                      size: 35,
                      color: Colors.black12,
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
             padding: EdgeInsets.fromLTRB(0,0, 0, 0),
              child:
              Stack(
                //key:   ,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(

                  borderRadius: BorderRadius.circular(120.0),
                    child: Image.file(profileimage),
                  ),
                  ),
                 
                  Align(
                    alignment: Alignment(0.26,1),
                  child: GestureDetector(
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
         
            ],
          ),
          form(),
          ]
        ),
      ) ,
      drawer: Sidedrawer(),
    );
  }

   
    Widget form(){
      return Column(
        children: <Widget>[
          //username
          formField('username', accountUsername, usernameController,TextInputType.text),
          //preferred name
          formField('screen name',accountPreferredName, preferredNameController,TextInputType.text),
          //bio
          formField('Bio',accountBio==null?' ':accountBio,bioController,TextInputType.text),
          //dob
          formField('Date Of Birth',accountDOB==null?'MM/DD/YYYY':accountDOB,dobController,TextInputType.text),
          //email(uneditable)
          formField('email',accountEmail,emailController,TextInputType.text),
        ],
      );
    }
    Widget formField(inputTitle,hintText,inputController,inType){
      return      Container(
            decoration: BoxDecoration(
              border: Border(
                 bottom: BorderSide(width: 0.2, color: Colors.white),
              )
            ),
           child: Column(
             children: <Widget>[
              prefix0.Row(

                             mainAxisAlignment: prefix0.MainAxisAlignment.start,

                children: <prefix0.Widget>[
                  Text(inputTitle,
                  style: prefix0.TextStyle(
                    fontSize: 14,
                    color: Colors.black
                  ),
                  ),
                ],
              ),
              inputTitle!='email'?TextFormField(
                controller: inputController,
                maxLines: 1,
                keyboardType: inType,
                autofocus: false,
                decoration: prefix0.InputDecoration(
                  hintText: hintText,
                  hintStyle: prefix0.TextStyle(
                    color: Colors.black
                  )
                ),
              ):
              //because you cannot edit the email address
              Text(hintText)
            ],)
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
    Future updateAccount() async{
            await databaseReference.collection("UserAccounts").document(userId)
      .updateData({
      'username': usernameController.text!=null?usernameController.text:accountUsername,
       'date of birth': dobController.text!=null?dobController.text:accountDOB,
      'preferred names': preferredNameController.text!=null?preferredNameController.text:accountPreferredName,
       'bio' :bioController.text!=null?bioController.text:accountBio,
       'profile picture':  profileurl!=null?profileurl:null,
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
  // print( );  
 }
}