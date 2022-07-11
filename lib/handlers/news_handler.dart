import 'dart:developer';

import 'package:cafe_news/handlers/api_handler.dart';
import 'package:cafe_news/handlers/request_handler.dart';
import 'package:cafe_news/helpers/toast.dart';
import 'package:cafe_news/models/feature_news_model.dart';
import 'package:cafe_news/models/news_category.dart';
import 'package:cafe_news/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NewsHandler with ChangeNotifier {
  // Feature News Data
  List<FeatureNewModel> _news = [];
  List<FeatureNewModel> get getFeatureNews => _news;
  setFeatureNews(List<FeatureNewModel> json) {
    _news = json;
    notifyListeners();
  }

  // News Details data
  NewsPostModel _detail =
      NewsPostModel(0, 0, 0, 'Not Available', "Not Available", "Not Available");
  NewsPostModel get getNewsDetail => _detail;

  // List of News Category
  final List<NewsCategoryModel> _newsCat = [];
  List<NewsCategoryModel> get getNewsCategory => _newsCat;

  // List of Post
  List<NewsPostModel> _post = [];
  List<NewsPostModel> get getPostData => _post;

  // Function to gatch News Category
  Future<bool> fatchNewsCategory() async {
    try {
      var response = await http.get(Uri.parse(CATEGORYLIST));
      // await RequestHandler.GET_REQUEST(apiCall: CATEGORYLIST, headers: {});
      log(response.body);
      log(response.toString());
      if (response != null) {
        // final dataList = response['data']['event'] as List;
        // _newsCat =
        //     dataList.map((e) => NewsCategoryModel.fromCategory(e)).toList();

        notifyListeners();
        return true;
      } else {
        null;
        return false;
      }
    } catch (e) {
      null;
      return false;
    }
  }

  // Function to get news by Id
  Future<bool> getNewsByCategory(String catId) async {
    try {
      var response = await RequestHandler.GET_REQUEST(
          apiCall: CATEGORYBY_ID + catId, headers: {});
      if (response != null) {
        log(response.toString());
        final postList = response['data']['event'] as List;
        _post = postList.map((e) => NewsPostModel.fromNews(e)).toList();
        notifyListeners();
        return true;
      } else {
        _post = [];
        notifyListeners();
        return false;
      }
    } catch (e) {
      toast("Technical Error! Please contact with support team");
      return false;
    }
  }

  Future<bool> fatchNewsDetail(String postId) async {
    try {
      var response = await RequestHandler.GET_REQUEST(
          apiCall: POSTBYID_API + postId, headers: {});
      if (response != null) {
        _detail = NewsPostModel.fromNews(response['data']['Single Post']);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
