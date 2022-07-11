import 'package:cafe_news/config/app_config.dart';

// Category API call path
const String CATEGORYLIST = "${BASE_URL}category";
const String CATEGORYBY_ID = "${BASE_URL}category/";

// Post API Call Path
const String POSTLISTAPI = "${BASE_URL}post";
const String POSTBYID_API = "${BASE_URL}post/";
// Auth Api Calls
const String LOGIN_API = "${BASE_URL}auth/login";
const String SIGN_UP_API = "${BASE_URL}auth/register";
const String FORGOT_PASS_API = "${BASE_URL}auth/forgotpassword";
const String RESET_PASS_API = "${BASE_URL}auth/reset-password";

// User Profile Activity Calls
const String USER_DETAILS = "${BASE_URL}userdetails"; // get method
const String UPDATE_PROFILE = "${BASE_URL}profile"; // post method

// Post Activity Calls
const String COMMENT_API =
    "${BASE_URL}comments"; // post method (token authorization)
const String SEARCH_API = "${BASE_URL}search?query="; // search text in params
