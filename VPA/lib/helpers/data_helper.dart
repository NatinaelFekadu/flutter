import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video_list_data.dart';
import '../models/video_model.dart';

class DataHelper {
  static Future<VideoListData> getVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('videos') ?? "";
    String appBackgroundColor = prefs.getString('appBackgroundColor') ?? "";

    if (jsonData.isEmpty) {
      try {
        var url = Uri.parse('https://app.et/devtest/list.json');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          jsonData = response.body;

          prefs.setString('videos', jsonData);

          final decodedData = json.decode(jsonData);
          appBackgroundColor =
              decodedData['appBackgroundHexColor'] ?? appBackgroundColor;
          prefs.setString('appBackgroundColor', appBackgroundColor);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    List<VideoModel> videos = [];
    if (jsonData.isNotEmpty) {
      final decodedData = json.decode(jsonData);
      if (decodedData.containsKey('videos')) {
        for (var video in decodedData['videos']) {
          videos.add(VideoModel.fromJson(video));
        }
      }
    }

    return VideoListData(
      appBackgroundColor: appBackgroundColor,
      videos: videos,
    );
  }
}
