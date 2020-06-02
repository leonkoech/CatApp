import 'dart:async';
import 'dart:io';

import 'package:async_loader/async_loader.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
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

class SignuporLogin extends StatefulWidget {
  
  @override
  _SignuporLoginState createState() => _SignuporLoginState();
}

class _SignuporLoginState extends State<SignuporLogin> {
  
 File profileimage;
bool _saving = false;
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


  //var head;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(



      child: Scaffold(
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
                shrinkWrap:true,
                children:<Widget>[signup()] ),
                ListView(
                children:<Widget>[login()] ),
                    
                 
                 ]
                 )
                 )
                 ),
                 ),
    inAsyncCall: _saving);
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
   print( profileurl);  
 }
 
 Widget login(){
   //settitle('Login');
      new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _saving = false;
      });
    });
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
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _saving = false;
      });
    });
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
                //key:   ,
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
              if(_password!=_confirmpassword){
               // 
               _showDialog(0,'Passwords Do Not Match');
                }
              if(_password.length<6){_showDialog(0,'password should be more than 6 characters');}
              else{
                signUp();
              }
              
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
    await postAvatar();
      await databaseReference.collection("UserAccounts").document(user.uid)
      .setData({
        'username': _username==null?'CatApp user':_username,
        'preferred names': _username!=null?_username:null,
        'profile picture': profileurl.toString(),
        'email': _email,
      });
      if(user.uid!=null){
        Navigator.popUntil(context, (route) {
            return route.settings.name == "/";
          });
          Fluttertoast.showToast(
        msg: "Successfully signed up and logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
    else
    {_showDialog(0,'There was an error.\nPlease try again later');}
    return user.uid;
  }  
   Future<String> logIn() async{
   AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email, password: _password);
    FirebaseUser user = result.user;
   if(user.uid!=null){
     Navigator.popUntil(context, (route) {
      return route.settings.name == "/";
    });
     Fluttertoast.showToast(
        msg: "Successfully logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
   }
    else{
      _showDialog(0,'There was an error.\nPlease try again later');
    }
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
//loads the profile page