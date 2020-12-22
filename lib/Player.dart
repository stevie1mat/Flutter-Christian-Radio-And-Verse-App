import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remotemusic/lsit.dart';
import 'package:remotemusic/model.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter_share/flutter_share.dart';

class Player extends StatefulWidget {
  ChristianChannels channel;
  Player(this.channel);
  @override
  _PlayerState createState() => new _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  String url;
  String image;
  String title;
  String subtitle;
  //Audio audio;
  // Future<void> share() async {
  //   await FlutterShare.share(
  //       title: 'Example share',
  //       text: 'Example share text',
  //       linkUrl: 'https://flutter.dev/',
  //       chooserTitle: 'Example Chooser Title');
  // }

  @override
  initState() {
    super.initState();

    subtitle = widget.channel.subtitle;
    title = widget.channel.title;
    url = widget.channel.url;
    image = widget.channel.imgurl;
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 5),
    );

    animationController.repeat();
    audioStart();
  }

  audioStart() async {
    if (await FlutterRadio.isPlaying()) {
      if (url != currentCh.url) {
        FlutterRadio.stop();
        FlutterRadio.play(url: url);
      } else {}
    } else {
      print("adsf");
      FlutterRadio.playOrPause(url: url);
    }
    playingStatus();
    currentCh = widget.channel;
    print('Audio Start OK');
  }

  Future playingStatus() async {
    //bool isP = await FlutterRadio.isPlaying();

    playerModel.update(true);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ScopedModel<PlayerModel>(
        model: playerModel,
        child: Material(
          child: new SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Stack(children: <Widget>[
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/originals/b9/c8/f8/b9c8f893c9a782033a01f47e0c0b1d6e.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(0.0),
                        topRight: const Radius.circular(0.0),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10),
                          child: IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () => Navigator.of(context).pop()),
                        ),
                      ]),
                  Center(
                      child: Container(
                    height: 320,
                    width: 320,
                    margin: const EdgeInsets.only(top: 140),
                    child: AnimatedBuilder(
                      animation: animationController,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(300.0)),
                          elevation: 15,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(300.0),
                                    topRight: const Radius.circular(300.0),
                                    bottomRight: const Radius.circular(300.0),
                                    bottomLeft: const Radius.circular(300.0),
                                  ),
                                ),
                              ))),
                      builder: (BuildContext context, Widget _widget) {
                        return Transform.rotate(
                          angle: animationController.value * 6.3,
                          child: _widget,
                        );
                      },
                    ),
                  )),
                ]),
                SizedBox(height: 60),
                Text(
                  title,
                  style: GoogleFonts.lato(
                      color: Colors.grey[700],
                      fontSize: 20,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.lato(
                      color: Colors.grey[500],
                      fontSize: 14,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 20),
                new Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        //background color of box
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.share_outlined),
                          ScopedModelDescendant<PlayerModel>(
                              builder: (context, child, model) =>
                                  FloatingActionButton(
                                      backgroundColor: Colors.green,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          model.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 35.0,
                                        ),
                                      ),
                                      onPressed: () async {
                                        FlutterRadio.playOrPause(url: url);
                                        bool isP =
                                            await FlutterRadio.isPlaying();
                                        model.update(null);
                                      })),
                        ],
                      ),
                    )),
                SizedBox(height: 30),
              ],
            ),
          )),
        ),
      ),
    );
  }

  onPressed() {
    print("aff");
    FlutterRadio.playOrPause(url: url);
  }
}
