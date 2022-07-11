import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cafe_news/helpers/toast.dart';
import 'package:http/http.dart' as http;

class RequestHandler {
  static Future<dynamic> GET_REQUEST({
    required String apiCall,
    required Map<String, String> headers,
  }) async {
    try {
      var request = http.Request('GET', Uri.parse(apiCall));

      headers.isEmpty ? null : request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      final data = await response.stream.bytesToString();
      log("Get Response Status :: $data");
      if (response.statusCode == 200) {
        final decoded = json.decode(data);
        return decoded;
      } else {
        var r = await response.stream.bytesToString();
        final decodeError = json.decode(r);
        log(decodeError.toString());
        toast(decodeError['message'].toString());
        toast("Error this : ${response.reasonPhrase}");
        return null;
      }
    } on HttpException catch (e) {
      log("get HTTP Exception :: ${e.message}");
      toast(e.message);
      toast("Http error : ${e.message}");
      return null;
    } catch (e) {
      log("get Normal Error :: $e");
      toast("Technical error GET :$e");
      return null;
    }
  }

  static Future<dynamic> SEND_REQUEST(
      {required String apiCall,
      Map<String, String> headers = const {},
      required Map<String, String> body,
      String singleFilePath = '',
      String singleFileName = '',
      String multiFileName = 'images[]',
      String requestType = "POST",
      List<String> filesPath = const []}) async {
    try {
      var request = http.MultipartRequest(requestType, Uri.parse(apiCall));
      body == {} ? null : request.fields.addAll(body);
      headers == {} ? null : request.headers.addAll(headers);
      if (singleFilePath.isNotEmpty || singleFilePath != '') {
        request.files.add(
            await http.MultipartFile.fromPath(singleFileName, singleFilePath));
      }
      if (filesPath.isNotEmpty) {
        for (var i = 0; i < filesPath.length; i++) {
          request.files.add(
              await http.MultipartFile.fromPath(multiFileName, filesPath[i]));
        }
      }
      log(request.url.toString());
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        final decoded = json.decode(data);
        return decoded;
      } else {
        var r = await response.stream.bytesToString();
        final decodeError = json.decode(r);
        log(decodeError.toString());
        toast(decodeError['message'].toString());
        toast("Error this : ${response.reasonPhrase}");
        return null;
      }
    } on HttpException catch (e) {
      toast(e.message);
      toast("Http error : ${e.message}");
      return null;
    } catch (e) {
      log(e.toString());
      toast("Technical error :$e");
      return null;
    }
  }
}
