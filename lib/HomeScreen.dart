import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remotemusic/Player.dart';
import 'package:remotemusic/lsit.dart';
import 'package:remotemusic/model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'gallery.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List list;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    list = getChannels();

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: ScopedModel<PlayerModel>(
          model: playerModel,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://assets.stickpng.com/thumbs/580b57fbd9996e24bc43bff4.png',
                    height: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Christian Radio',
                    style: GoogleFonts.lato(
                        color: Colors.grey[700],
                        fontSize: 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              centerTitle: true,
              actions: [
                Icon(Icons.menu, color: Colors.grey[500]),
                SizedBox(
                  width: 10,
                )
              ],
              bottom: TabBar(
                indicatorColor: Colors.grey[400],
                tabs: [
                  Tab(
                      icon:
                          Icon(Icons.radio, color: Colors.grey[500], size: 20)),
                  Tab(
                      icon: Icon(Icons.image_outlined,
                          color: Colors.grey[500], size: 23)),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => Player(currentCh)));
              },
              child: ScopedModelDescendant<PlayerModel>(
                  builder: (context, child, model) => model.isPlaying
                      ? Icon(Icons.pause)
                      : Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
              backgroundColor: Colors.green,
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 20, bottom: 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => Player(list[index])));
                            },
                            child:
                                //shape: ShapeBorder.lerp(1,2,3),
                                Column(
                              children: <Widget>[
                                // AspectRatio(
                                //     aspectRatio: 18 / 11,
                                //     child: Image.network(
                                //       list[index].imgurl,
                                //       fit: BoxFit.fill,
                                //     )),
                                // Text(list[index].title)
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[200],
                                            blurRadius:
                                                10.0, // soften the shadow
                                            spreadRadius:
                                                2.0, //extend the shadow
                                            offset: Offset(
                                              0, // Move to right 10  horizontally
                                              4, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ]),
                                    height: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListTile(
                                        leading: Container(
                                          width: 58,
                                          child: Material(
                                            elevation: 5,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: CircleAvatar(
                                                  radius: 90,
                                                  backgroundImage: NetworkImage(
                                                    list[index].imgurl,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          list[index].title,
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[800],
                                              letterSpacing: 1,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        subtitle: Text(
                                          list[index].subtitle,
                                          style: GoogleFonts.lato(
                                              color: Colors.grey[500],
                                              letterSpacing: 1,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        trailing: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.pink[400],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.pink[200],
                                                    blurRadius:
                                                        6.0, // soften the shadow
                                                    spreadRadius:
                                                        1.0, //extend the shadow
                                                    offset: Offset(
                                                      0, // Move to right 10  horizontally
                                                      0, // Move to bottom 10 Vertically
                                                    ),
                                                  )
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.arrow_forward_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )),
                                        isThreeLine: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                GalleryPage(),
              ],
            ),
          ),
        ));
  }
}

class Gallery {}
