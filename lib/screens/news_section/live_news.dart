import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/screens/news_section/video_play_screen.dart';
import 'package:flutter/material.dart';

class LiveNewsScreen extends StatefulWidget {
  const LiveNewsScreen({Key? key}) : super(key: key);

  @override
  State<LiveNewsScreen> createState() => _LiveNewsScreenState();
}

class _LiveNewsScreenState extends State<LiveNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: whiteColor,
        foregroundColor: blackColor,
        title: Text(
          "Live New Section",
          style: getTheme(context).headline3!.copyWith(color: defaultColor),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: liveNews.length,
              itemBuilder: (context, i) => GestureDetector(
                    onTap: () => pushTo(
                        VideoPlayerScreen(videoUrl: liveNews[i].url), context),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                liveNews[i].thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              // padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: whiteColor.withOpacity(0.7)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: blackColor,
                                  )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    width: getWidth(context) - 35,
                                    decoration: BoxDecoration(
                                        color: blackColor.withOpacity(0.4),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(15))),
                                    child: Text(
                                      liveNews[i].description,
                                      style: getTheme(context)
                                          .headline4!
                                          .copyWith(color: whiteColor),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      )),
    );
  }
}

class LiveNewsModel {
  String url;
  String thumbnail;
  String id;
  String description;
  LiveNewsModel(this.url, this.thumbnail, this.id, this.description);
}

List<LiveNewsModel> liveNews = [
  LiveNewsModel("https://youtu.be/CORX2abNRBc", thumb1, "1",
      "Live News | Maharashtra Politics | Uddhav Thackeray vs Eknath Shinde | Latest Breaking Updates"),
  LiveNewsModel("https://youtu.be/Cy_6-_XUW-c", thumb2, "2",
      "AajTak LIVE: Special Report| Udaipur Murder Case LIVE Updates | Maharashtra Political Crisis")
];
