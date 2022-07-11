import 'package:cafe_news/handlers/news_handler.dart';
import 'package:cafe_news/models/feature_news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DummyDataProvider {
  DummyDataProvider(BuildContext context) {
    setFeatureNews(context);
  }

  setFeatureNews(BuildContext context) {
    final db = Provider.of<NewsHandler>(context, listen: false);
    db.setFeatureNews(newsList);
  }
}

String news =
    "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles.";
