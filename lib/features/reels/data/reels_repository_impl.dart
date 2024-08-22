import 'dart:convert';

import 'package:socialmedia_technicalround_app/features/reels/domain/entities/main_model.dart';

import '../application/bloc/reels_bloc.dart';
import '../domain/repository/reels_repository.dart';

import 'package:http/http.dart' as http;

class ReelsRepositoryImpl implements ReelsRepository {
  @override
  Future getReelsData(String pagecount) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.ulearna.com/bytes/all?page=$pagecount&limit=10&country=United+States'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      dynamic data = jsonDecode(responseBody);
      // final temp = Data.fromJson(data);

      // print(rep['data']);
      Data rr = Data.fromJson(data['data']);
      print(rr.runtimeType);

      List<Datum> responseData = rr.data;
      // print(responseData);

      return ReelsCompleted(responseData: responseData);
    } else {
      return ApiErrorResponseModel(
          message:
              "${response.statusCode}: ${response.reasonPhrase.toString()}",
          statusCode: response.statusCode);
    }
  }
}
