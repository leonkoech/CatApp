import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//cat images route
var cardAspectRatio = 12.0 / 16.0;
 double widgetAspectRatio = cardAspectRatio * 1.2;
   var padding = 20.0;
  var verticalInset = 20.0;
class RedImages extends StatefulWidget {
RedImages({Key key }) : super(key: key);


@override
ReddetailsState createState() => ReddetailsState();
}
class ReddetailsState extends State<RedImages> {

  var currentPage = redimages.length - 1.0;
  String header;
  @override
  Widget build(BuildContext context) {
    
     PageController controller = PageController(initialPage: redimages.length- 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
            leading: Builder(
            builder: (BuildContext context) {
            return Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: IconButton(
            iconSize: 40.0,
          icon: const Icon(Icons.navigate_before,color: Colors.black,),
          onPressed: () { Navigator.pop(context); },
          )
      );
    },
    ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          color: Colors.transparent,
          child: Stack(
                    children: <Widget>[
                      new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < redimages.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      redimages[i],
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(redtitle[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "Futura")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ), 
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    ),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: redimages.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
        ),
      ),
    );
  }
}
class BlackImages extends StatefulWidget {
BlackImages({Key key }) : super(key: key);


@override
BlackdetailsState createState() => BlackdetailsState();
}
class BlackdetailsState extends State<BlackImages> {
  var currentPage = blackimages.length - 1.0;
  String header;
  @override
  Widget build(BuildContext context) {
    
     PageController controller = PageController(initialPage: blackimages.length- 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
            leading: Builder(
            builder: (BuildContext context) {
            return Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: IconButton(
            iconSize: 40.0,
          icon: const Icon(Icons.navigate_before,color: Colors.black,),
          onPressed: () { Navigator.pop(context); },
          )
      );
    },
    ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          color: Colors.transparent,
          child: Stack(
                    children: <Widget>[
                      new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < blackimages.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      blackimages[i],
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(blacktitle[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "Futura")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 12.0, bottom: 12.0),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 22.0, vertical: 6.0),
                            //     child: Text(title[i],
                            //         style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    ),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: blackimages.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
        ),
      ),
    );
  }
}
class YellowImages extends StatefulWidget {
YellowImages({Key key }) : super(key: key);


@override
YellowdetailsState createState() => YellowdetailsState();
}
class YellowdetailsState extends State<YellowImages> {
  var currentPage = yellowimages.length - 1.0;
  String header;
  @override
  Widget build(BuildContext context) {
    
     PageController controller = PageController(initialPage: yellowimages.length- 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
            leading: Builder(
            builder: (BuildContext context) {
            return Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: IconButton(
            iconSize: 40.0,
          icon: const Icon(Icons.navigate_before,color: Colors.black,),
          onPressed: () { Navigator.pop(context); },
          )
      );
    },
    ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          color: Colors.transparent,
          child: Stack(
                    children: <Widget>[
                      new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < yellowimages.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      yellowimages[i],
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(yellowtitle[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "Futura")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 12.0, bottom: 12.0),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 22.0, vertical: 6.0),
                            //     child: Text(title[i],
                            //         style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    ),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: yellowimages.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
        ),
      ),
    );
  }
}
class BlueImages extends StatefulWidget {
BlueImages({Key key }) : super(key: key);


@override
BluedetailsState createState() => BluedetailsState();
}
class BluedetailsState extends State<BlueImages> {
  var currentPage = blueimages.length - 1.0;
  String header;
  @override
  Widget build(BuildContext context) {
    
     PageController controller = PageController(initialPage: blueimages.length- 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
            leading: Builder(
            builder: (BuildContext context) {
            return Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: IconButton(
            iconSize: 40.0,
          icon: const Icon(Icons.navigate_before,color: Colors.black,),
          onPressed: () { Navigator.pop(context); },
          )
      );
    },
    ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          color: Colors.transparent,
          child: Stack(
                    children: <Widget>[
                      new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < blueimages.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      blueimages[i],
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(bluetitle[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "Futura")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 12.0, bottom: 12.0),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 22.0, vertical: 6.0),
                            //     child: Text(title[i],
                            //         style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    ),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: blueimages.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
        ),
      ),
    );
  }
}
class GreenImages extends StatefulWidget {
  final catId;
  final length;
GreenImages({Key key, this.catId, this.length }) : super(key: key);


@override
GreendetailsState createState() => GreendetailsState(catId,length);
}
class GreendetailsState extends State<GreenImages> {
   final catId;
  final length;
  var currentPage;
  String header;

  GreendetailsState(this.catId, this.length);
  @override
  Widget build(BuildContext context) {
    currentPage=(length.toInt()- 1);
     PageController controller = PageController(initialPage: (length.toInt()- 1));
    controller.addListener(() {
      
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
            leading: Builder(
            builder: (BuildContext context) {
            return Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: IconButton(
            iconSize: 34.0,
          icon: const Icon(Icons.navigate_before,color: Colors.black,),
          onPressed: () { Navigator.pop(context); },
          )
      );
    },
    ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          color: Colors.transparent,
          child: Stack(
                    children: <Widget>[
                      new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      greenimages[i],
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(greentitle[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "Futura")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    ),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
        ),
      ),
    );
  }
}
class OrangeImages extends StatefulWidget {
OrangeImages({Key key }) : super(key: key);


@override
OrangedetailsState createState() => OrangedetailsState();
}
class OrangedetailsState extends State<OrangeImages> {

  var currentPage = 4 - 1.0;
  String header;
  @override
  Widget build(BuildContext context) {
    
     PageController controller = PageController(initialPage: 4 - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return  Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
          color: Colors.transparent,
          child: Stack(
                    children: <Widget>[
                      new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < orangeimages.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      orangeimages[i],
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(orangetitle[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "Futura")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 12.0, bottom: 12.0),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 22.0, vertical: 6.0),
                            //     child: Text(title[i],
                            //         style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    ),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: redimages.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
        ),
      
    );
  }
}

class ScrollImagewidget extends StatelessWidget {
  final  imageurl;
   const ScrollImagewidget(this.imageurl);
  @override
  Widget build(BuildContext context) {
   return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
          child: Container(
          width: 260.0,
          child: Image.network(imageurl),
          )
      );

  }
}
const List<Widget> redimages = [
 
 ScrollImagewidget(Colors.green),
 ScrollImagewidget(Colors.orange),
 ScrollImagewidget(Colors.blue),
  ScrollImagewidget(Colors.black),
  ScrollImagewidget(Colors.red),
];

const List<String> redtitle = [
  
  "Green",
  "Orange",
  "Blue",
    "Black",
    "Red",
];
//orange
 const  List<Widget> orangeimages = [
 ScrollImagewidget(Colors.red),
 ScrollImagewidget(Colors.blue),
  ScrollImagewidget(Colors.black),
 ScrollImagewidget(Colors.green),
 ScrollImagewidget(Colors.orange),
];

const List<String> orangetitle = [
  "Red",
  "Blue",
    "Black",
  "Green",
  "Orange",
];
//for long haired
const List<Widget>blackimages = [

 ScrollImagewidget(Colors.green),
 ScrollImagewidget(Colors.orange),
  ScrollImagewidget(Colors.red),
 ScrollImagewidget(Colors.blue),
  ScrollImagewidget(Colors.black),
];

const List<String> blacktitle = [
 
  "Green",
  "Orange",
   "Red",
  "Blue",
    "Black",
];
//for short haired

const List<Widget> greenimages = [
 ScrollImagewidget(Colors.red),
  ScrollImagewidget(Colors.black),
 ScrollImagewidget(Colors.orange),
 ScrollImagewidget(Colors.blue),
 ScrollImagewidget(Colors.green),
];

const List<String> greentitle = [
  "Red",
  "Blue",
    "Black",
  "Green",
  "Orange",
];
const List<Widget> blueimages = [
 ScrollImagewidget(Colors.red),
  ScrollImagewidget(Colors.black),
 ScrollImagewidget(Colors.orange),

 ScrollImagewidget(Colors.green),
  ScrollImagewidget(Colors.blue),
];

const List<String> bluetitle = [
  "Red",
  
    "Black",
  "Green",
  "Orange",
  "Blue",
];
const List<Widget> yellowimages = [
 ScrollImagewidget(Colors.red),
  ScrollImagewidget(Colors.black),
 ScrollImagewidget(Colors.orange),

 ScrollImagewidget(Colors.green),
  ScrollImagewidget(Colors.yellow),
];

const List<String> yellowtitle = [

  "Red",
  "Black",
  "Green",
  "Orange",
  "Yellow",
];
