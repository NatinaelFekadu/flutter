import 'package:flutter/material.dart';
import '../helpers/data_helper.dart';
import '../models/video_list_data.dart';
import 'list_view_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<VideoListData> _fetchVideos;

  @override
  void initState() {
    super.initState();
    _fetchVideos = DataHelper.getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _fetchVideos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.hasData &&
                  (snapshot.data as VideoListData).videos.isNotEmpty) {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListViewScreen(
                          videoListData: snapshot.data as VideoListData),
                    ),
                  );
                });
                return Container();
              } else {
                return const Text('No data available.');
              }
            }
          },
        ),
      ),
    );
  }
}
