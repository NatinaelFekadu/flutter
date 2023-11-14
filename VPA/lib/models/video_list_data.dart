import 'video_model.dart';

class VideoListData {
  final String appBackgroundColor;
  final List<VideoModel> videos;

  VideoListData({
    required this.appBackgroundColor,
    required this.videos,
  });

  factory VideoListData.fromJson(Map<String, dynamic> json) {
    List<VideoModel> videos = [];
    if (json.containsKey('videos')) {
      for (var video in json['videos']) {
        videos.add(VideoModel.fromJson(video));
      }
    }

    return VideoListData(
      appBackgroundColor: json['appBackgroundHexColor'] ?? '',
      videos: videos,
    );
  }
}
