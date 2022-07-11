import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import '../../../config/icons_and_images.dart';
import '../../../config/stylesheet.dart';

class NewsTileOne extends StatelessWidget {
  Function? ontap;
  NewsPostModel news;
  NewsTileOne({Key? key, this.ontap, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 6,
      child: GestureDetector(
        onTap: () => ontap!(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: blackColor.withOpacity(0.1))),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: Image.network(
                    news.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getTheme(context).headline3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              radius: 13,
                              backgroundImage: AssetImage(bbcLogo),
                            ),
                            putHorizontalSpace(10),
                            Text(
                              "BBC News",
                              style: getTheme(context)
                                  .headline4!
                                  .copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                        Chip(
                            backgroundColor: whiteColor,
                            side: const BorderSide(color: defaultColor),
                            label: Text(
                              "Sports",
                              style: getTheme(context)
                                  .headline4!
                                  .copyWith(color: defaultColor, fontSize: 12),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              iconLike,
                              width: 15,
                              color: defaultColor.withOpacity(0.4),
                            ),
                            putHorizontalSpace(5),
                            Text(
                              "316k",
                              style: getTheme(context)
                                  .headline4!
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        putHorizontalSpace(10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              iconComments,
                              width: 15,
                              color: defaultColor.withOpacity(0.4),
                            ),
                            putHorizontalSpace(5),
                            Text(
                              "105k",
                              style: getTheme(context)
                                  .headline4!
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          iconBookMark,
                          width: 15,
                          color: defaultColor.withOpacity(0.4),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  dom.Document convertText(String text) {
    dom.Document myDocument = htmlparser.parse(text);
    return myDocument;
  }
}

String dummyNews =
    "ICC Women's World Cup: Four players from champion side Australia featured in the ICC's 'Most Valuable Team'.";
