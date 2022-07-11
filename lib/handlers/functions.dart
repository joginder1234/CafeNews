// Fatch User Profile
import 'package:cafe_news/handlers/api_handler.dart';
import 'package:cafe_news/handlers/request_handler.dart';

bool isLoggedIn = false;

Future<dynamic> getUserProfile() async {
  try {
    var response = await RequestHandler.GET_REQUEST(
        apiCall: USER_DETAILS, headers: {"Authorization": ''});
  } catch (e) {}
}

Future<dynamic> postComment(String comment, String postId) async {
  try {
    var response = await RequestHandler.SEND_REQUEST(
        apiCall: COMMENT_API,
        body: {"post_id": postId, "comment": comment},
        headers: {"Authorization": ''});
  } catch (e) {}
}
