import 'model.dart';

class ChristianChannels {
  String url;
  String title;
  String subtitle;

  String imgurl;
  ChristianChannels({this.title, this.subtitle, this.url, this.imgurl});

  factory ChristianChannels.fromJson(Map<String, dynamic> parsedJson) {
    return ChristianChannels(
        title: parsedJson['title'].toString(),
        subtitle: parsedJson['subtitle'].toString(),
        url: parsedJson['url'],
        imgurl: parsedJson['imgurl'].toString());
  }
  static getCategories(List<ChristianChannels> list) {
    return Set.from(list.map((ch) => ch.title)).toList();
  }
}

List getChannels() {
  return [
    ChristianChannels(
        title: "Vision Christian Radio",
        subtitle: "Connecting Faith To Life",
        url: "https://direct.sharp-stream.com/ucbau.mp3",
        imgurl: "https://cdn-radiotime-logos.tunein.com/s87183q.png"),
    ChristianChannels(
        url: "https://direct.sharp-stream.com/ucbau.mp3",
        title: "Christian FM",
        subtitle: "Theresa Ross",
        imgurl:
            "https://scontent.fdel9-1.fna.fbcdn.net/v/t1.0-9/88959020_2945831302142410_4771031358103355392_o.jpg?_nc_cat=103&ccb=2&_nc_sid=dd9801&_nc_ohc=qs71trLWNfAAX_aaqWZ&_nc_ht=scontent.fdel9-1.fna&oh=9622be39a8ab67078a553f2046267bb6&oe=5FFCCD41"),
    ChristianChannels(
        title: "Christian Life Radio",
        url: "https://ice64.securenetsystems.net/CLR1MP3",
        subtitle: "Christian Life & Easy",
        imgurl: "https://cdn-radiotime-logos.tunein.com/s112984q.png"),
    ChristianChannels(
        url:
            "https://audio-edge-hy4wy.blr.d.radiomast.io/4d0743b5-b63a-43f1-9f7f-e8a04abe9367",
        title: "Premium Christian Radio",
        subtitle: "Inspirational Life",
        imgurl:
            "https://cdn-profiles.tunein.com/s17132/images/logoq.jpg?t=160226"),
    ChristianChannels(
        url: "https://streams.calmradio.com:3228/stream",
        title: "Calm Radio - Christian",
        subtitle: "Cannada Radio",
        imgurl: "https://cdn-profiles.tunein.com/s142210/images/logoq.png?t=1"),
    ChristianChannels(
        url: "https://ice64.securenetsystems.net/CCR1MP3",
        subtitle: "US",
        title: "Cape Christian Radio",
        imgurl: "https://cdn-radiotime-logos.tunein.com/s54344q.png"),
  ];
}

ChristianChannels currentCh = getChannels()[0];
PlayerModel playerModel = PlayerModel();
