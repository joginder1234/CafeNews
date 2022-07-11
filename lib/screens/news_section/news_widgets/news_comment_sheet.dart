import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/helpers/basic_widgets/custom_listtile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/stylesheet.dart';
import '../../../helpers/basic_widgets/custom_textfield.dart';
import '../../../helpers/helper_functions.dart';

class NewsCommentBottomSheet extends StatefulWidget {
  const NewsCommentBottomSheet({Key? key}) : super(key: key);

  @override
  State<NewsCommentBottomSheet> createState() => _NewsCommentBottomSheetState();
}

class _NewsCommentBottomSheetState extends State<NewsCommentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: getHeight(context) * 0.85),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sheetHeader(context),
          const Divider(),
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
                    hint: "Add a comment..",
                    showBorder: true,
                  ),
                ),
              )
            ],
          ),
          putVarticalSpace(15),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (ctx, i) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: blackColor.withOpacity(0.1),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomListTileView(
                        leadingRadius: 25,
                        title: "Jenny Wilson",
                        subtitle: "3 days ago",
                      ),
                      const Divider(),
                      Text(
                        "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc,",
                        style: getTheme(context).headline5,
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          staticIcon(context, "875", iconLike),
                          staticIcon(context, "76", iconDislike),
                          staticIcon(context, "495", iconComments),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile _sheetHeader(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text.rich(TextSpan(
          text: "Comments",
          style: getTheme(context).headline3,
          children: [
            TextSpan(
                text: "  170.5k",
                style:
                    getTheme(context).headline3!.copyWith(color: defaultColor))
          ])),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                iconOptions,
                width: 20,
                color: defaultColor,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                color: defaultColor,
              ))
        ],
      ),
    );
  }
}
