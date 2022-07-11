import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../config/stylesheet.dart';
import '../../../helpers/helper_functions.dart';
import '../../../models/feature_news_model.dart';

class FeatureNewsCarouselSlider extends StatelessWidget {
  List<FeatureNewModel> featureNews;
  FeatureNewsCarouselSlider({Key? key, required this.featureNews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CarouselSlider(
      items: featureNews
          .map((e) => SizedBox(
                width: getWidth(context) - 30,
                height: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        e.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.description,
                            style: theme.headline4!.copyWith(
                                color: whiteColor,
                                shadows: [
                                  const Shadow(
                                      color: blackColor, offset: Offset(1, 2))
                                ]),
                          ),
                          FlatButton(
                              color: defaultColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {},
                              child: Text(
                                "Read Now",
                                style: theme.headline4!
                                    .copyWith(color: whiteColor),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: false,
        viewportFraction: 1,
        aspectRatio: 2.5,
        initialPage: 0,
      ),
    );
  }
}
