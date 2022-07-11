import 'package:cafe_news/config/dummy_data.dart';
import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/handlers/news_handler.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_textfield.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/screens/home/base_widgets/feature_news_carousal.dart';
import 'package:cafe_news/screens/news_section/news_detail_screen.dart';
import 'package:cafe_news/screens/news_section/news_widgets/news_tile_one.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/news_category.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> shareNews = [];
  List<String> newsOptionsList = [
    "Trending",
    "Latest",
    "Politics",
    "Health",
    "Sports",
  ];

  List<String> newsSectionList = [
    shareLogo,
    stockLogo,
    globalLogo,
    financeLogo
  ];
  int _selectedSection = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DummyDataProvider(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final newsData = Provider.of<NewsHandler>(context);
    final newsCategory = newsData.getNewsCategory;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0,
        title: Image.asset(
          appLogo,
          height: getAppbarHeight(context) * 0.8,
          fit: BoxFit.fitHeight,
        ),
        actions: [
          createIconButton(iconNotification, () {}),
          putHorizontalSpace(15)
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          putVarticalSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  child: ExpandedTextField(
                    sufixIcon: iconSearch,
                    sufixColor: blackColor,
                    showBorder: true,
                    hint: "Search...",
                  ),
                )),
                putHorizontalSpace(15),
                createIconButton(iconOptions, () {})
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  setSectionDivider(
                      context: context,
                      heading: "Featured",
                      showButton: true,
                      buttonTitle: "View all",
                      ontap: () {}),
                  putVarticalSpace(10),
                  FeatureNewsCarouselSlider(
                      featureNews: newsData.getFeatureNews),
                  putVarticalSpace(15),
                  setSectionDivider(
                      context: context, heading: "Stock Highlights"),
                  putHorizontalSpace(10),
                  _stockTile(theme),
                  const Divider(),
                  setSectionDivider(
                      context: context,
                      heading: "Latest Stories",
                      showButton: false),
                  putVarticalSpace(15),
                  _storyTypes(newsData.getNewsCategory),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  ListView.builder(
                      itemCount: newsData.getPostData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => NewsTileOne(
                            ontap: () => pushTo(
                                NewsDetailScreen(
                                  newsId: newsData.getPostData[i].id.toString(),
                                ),
                                context),
                            news: newsData.getPostData[i],
                          ))
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Row _storyTypes(List<NewsCategoryModel> data) {
    return Row(
      children: data
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => {
                    setState(() => _selectedSection = data.indexOf(e)),
                    Provider.of<NewsHandler>(context, listen: false)
                        .getNewsByCategory(e.newsId.toString())
                  },
                  child: AnimatedScale(
                    scale: _selectedSection == data.indexOf(e) ? 1.15 : 1,
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.8,
                              color: _selectedSection == data.indexOf(e)
                                  ? defaultColor
                                  : Colors.transparent),
                          shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset(e.image),
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Row _stockTile(TextTheme theme) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: defaultColor.withOpacity(0.03),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(teslaLogo),
          ),
        ),
        putHorizontalSpace(10),
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "TSLA",
                  style: theme.headline3,
                ),
                putVarticalSpace(10),
                Text(
                  "Tesla Inc",
                  style: theme.headline3!.copyWith(
                      color: blackColor.withOpacity(0.2), fontSize: 12),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          // color: defaultColor,
          width: getWidth(context) * 0.3,
          height: 50,
          child: SfCartesianChart(
              // Initialize category axis
              enableSideBySideSeriesPlacement: false,
              enableAxisAnimation: false,
              plotAreaBorderColor: Colors.transparent,
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: CategoryAxis(isVisible: false),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 38),
                      SalesData('Apr', 48),
                      SalesData('May', 120),
                      SalesData('Jun', 80),
                      SalesData('July', 86),
                      SalesData('aug', 170),
                      SalesData('sep', 165),
                      SalesData('oct', 185)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales),
              ]),
        ),
        putHorizontalSpace(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "\$909.68",
              style: theme.headline3,
            ),
            putVarticalSpace(10),
            Text(
              "19,43%(+1.75%)",
              style: theme.headline4!.copyWith(color: greenColor, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}

String dummyImage =
    "https://gumlet.assettype.com/saamtv%2F2022-03%2F65ec559f-b39e-4f79-a43c-4af80dc22700%2FSaam_Templet_Banner_new__41_.jpg?auto=format%2Ccompress&fit=max&format=webp&w=400&dpr=2.6";

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
