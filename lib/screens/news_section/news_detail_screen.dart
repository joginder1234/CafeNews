import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/handlers/functions.dart';
import 'package:cafe_news/handlers/news_handler.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_textfield.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/screens/auth/signin.dart';
import 'package:cafe_news/screens/news_section/news_widgets/news_comment_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class NewsDetailScreen extends StatefulWidget {
  String newsId;
  NewsDetailScreen({Key? key, required this.newsId}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final List<String> _tagsList = [
    "#politics",
    "#usa",
    "#bbc",
    "#news",
    "#america",
    "#new",
  ];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  getDetail() async {
    setState(() => _loading = true);
    await Provider.of<NewsHandler>(context, listen: false)
        .fatchNewsDetail(widget.newsId)
        .then((value) {
      setState(() => _loading = false);
      // Future.delayed(const Duration(milliseconds: 500), () {
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final detail = Provider.of<NewsHandler>(context).getNewsDetail;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        foregroundColor: defaultColor,
        actions: [
          createIconButton(iconShare, () => share()),
          createIconButton(iconBookMark, () {}),
          createIconButton(iconMoreVert, () {}),
        ],
      ),
      body: SafeArea(
          child: _loading
              ? const Expanded(
                  child: SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: defaultColor,
                    ),
                  ),
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              detail.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        putVarticalSpace(15),
                        Text(
                          detail.title,
                          style: getTheme(context).headline3,
                        ),
                        putVarticalSpace(15),
                        Wrap(
                          spacing: 10,
                          children: [
                            Chip(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                side: const BorderSide(color: defaultColor),
                                backgroundColor: whiteColor,
                                label: Text(
                                  "Sports",
                                  style: getTheme(context).headline4!.copyWith(
                                      fontSize: 12, color: defaultColor),
                                )),
                            staticIcon(
                                context, detail.views.toString(), iconEye),
                            staticIcon(context, "381.2k", iconLike),
                            staticIcon(context, "107.8k", iconComments),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(),
                        ),
                        // ListTile(
                        //   contentPadding: EdgeInsets.zero,
                        //   leading: const CircleAvatar(
                        //     backgroundImage: AssetImage(bbcLogo),
                        //     radius: 25,
                        //   ),
                        //   title: Text(
                        //     "BBC News",
                        //     style: getTheme(context)
                        //         .headline3!
                        //         .copyWith(color: defaultColor),
                        //   ),
                        //   subtitle: Text(
                        //     "5 days ago",
                        //     style:
                        //         getTheme(context).headline4!.copyWith(fontSize: 13),
                        //   ),
                        //   trailing: FlatButton.icon(
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(50)),
                        //       color: defaultColor.withOpacity(0.5),
                        //       onPressed: () {},
                        //       icon: const Icon(
                        //         Icons.add,
                        //         color: whiteColor,
                        //       ),
                        //       label: Text("Follow",
                        //           style: getTheme(context)
                        //               .headline4!
                        //               .copyWith(color: whiteColor))),
                        // ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(),
                        ),
                        Html(
                          customTextStyle: (node, baseStyle) =>
                              getTheme(context).headline5,
                          data: detail.body,
                        ),

                        putVarticalSpace(15),
                        Wrap(
                          spacing: 10,
                          children: _tagsList
                              .map((e) => Chip(
                                  backgroundColor: whiteColor,
                                  side: const BorderSide(color: defaultColor),
                                  label: Text(
                                    e,
                                    style: getTheme(context)
                                        .headline4!
                                        .copyWith(color: defaultColor),
                                  )))
                              .toList(),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Is this news helpful?",
                            style: getTheme(context).headline3,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              staticIcon(context, "372.1k", iconLike),
                              staticIcon(context, "3.8k", iconDislike),
                            ],
                          ),
                        ),
                        putVarticalSpace(15),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: blackColor.withOpacity(0.2)),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text.rich(TextSpan(
                                    text: "Comments",
                                    style: getTheme(context).headline3,
                                    children: [
                                      TextSpan(
                                          text: "  170.5k",
                                          style: getTheme(context)
                                              .headline3!
                                              .copyWith(color: defaultColor))
                                    ])),
                                trailing: SvgPicture.asset(
                                  iconSort,
                                  height: 15,
                                  color: defaultColor,
                                ),
                              ),
                              const Divider(),
                              putVarticalSpace(10),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(profileLogo),
                                  ),
                                  putHorizontalSpace(10),
                                  Expanded(
                                    child: SizedBox(
                                      child: ExpandedTextField(
                                        readonly: true,
                                        hint: "Add a comment..",
                                        showBorder: true,
                                        ontap: () => !isLoggedIn
                                            ? showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      title: Text(
                                                        "Login",
                                                        style: getTheme(context)
                                                            .headline3,
                                                      ),
                                                      content: const Text(
                                                          "Please login to post your comment"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () => pushTo(
                                                                const SignInScreen(),
                                                                context),
                                                            child: Text(
                                                              "Login",
                                                              style: getTheme(
                                                                      context)
                                                                  .headline4!
                                                                  .copyWith(
                                                                      color:
                                                                          defaultColor),
                                                            ))
                                                      ],
                                                    ))
                                            : showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        20))),
                                                context: context,
                                                builder: (context) =>
                                                    StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return const NewsCommentBottomSheet();
                                                    })),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
                        setSectionDivider(
                            context: context,
                            heading: "Related News",
                            showButton: true,
                            buttonTitle: "See all",
                            buttonColor: defaultColor),
                        // ListView.builder(
                        //     itemCount: 4,
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemBuilder: (ctx, i) => NewsTileOne())
                      ],
                    ),
                  ),
                )),
    );
  }

  dom.Document convertText(String text) {
    dom.Document myDocument = htmlparser.parse(text);
    return myDocument;
  }
}
