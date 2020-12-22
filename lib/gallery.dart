import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class Spacecraft {
  final String id;
  final String name, imageUrl, propellant, details;

  Spacecraft(
      {this.id, this.name, this.imageUrl, this.propellant, this.details});

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      id: jsonData['id'],
      imageUrl: jsonData['image_url'],
    );
  }
}

class CustomListView extends StatefulWidget {
  final List<Spacecraft> spacecrafts;

  CustomListView(this.spacecrafts);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  bool isPlaying;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Widget build(context) {
    return ListView.builder(
      itemCount: widget.spacecrafts.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(widget.spacecrafts[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Spacecraft spacecraft, BuildContext context) {
    _toastInfo(String info) {
      Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
    }

    final snackBar = SnackBar(
      content: Text('Saved Image To Gallery', textAlign: TextAlign.center),
    );
    _getHttp() async {
      var response = await Dio().get(spacecraft.imageUrl,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: spacecraft.id + "2019");
      print(result);
      Scaffold.of(context).showSnackBar(snackBar);
    }

    Future<void> _shareImage() async {
      try {
        var request = await HttpClient().getUrl(Uri.parse(spacecraft.imageUrl));
        var response = await request.close();
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
        await Share.file('YPECWR', 'amlog.jpg', bytes, 'image/jpg');
      } catch (e) {
        print('error: $e');
      }
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
                // A simplified version of dialog.
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.clear, color: Colors.white, size: 30)),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height - 100,
                      child: PhotoView(
                          imageProvider: NetworkImage(
                        spacecraft.imageUrl,
                      ))),
                ])),
          );
        },
      );
    }

    return new ListTile(
      title: new Card(
          elevation: 0,
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                //background color of box
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 10.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    0.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: InkWell(
              onTap: () {
                _showMyDialog();
              },
              child: Stack(children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: CachedNetworkImage(
                          imageUrl: spacecraft.imageUrl,
                          fit: BoxFit.fill,
                          // placeholder: (context, url) => ImageLoading(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.cloud_download,
                              color: Colors.black54,
                            ),
                            onPressed: () => _getHttp(),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.black54,
                            ),
                            onPressed: () => _shareImage(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          )),
    );
  }
}

class GalleryPage extends StatelessWidget {
  Future<List<Spacecraft>> downloadJSON() async {
    final jsonEndpoint = "https://sjmodelagency.com/app/radioapp/radioapp.php";

    final response = await get(jsonEndpoint);

    if (response.statusCode == 200) {
      List spacecrafts = json.decode(response.body);
      return spacecrafts
          .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
          .toList();
    } else
      throw Exception(
          'We were not able to successfully download the json data.');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(),
      home: new Scaffold(
        body: new Center(
          child: new FutureBuilder<List<Spacecraft>>(
            future: downloadJSON(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Spacecraft> spacecrafts = snapshot.data;

                return new CustomListView(spacecrafts);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
