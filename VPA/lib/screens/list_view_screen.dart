import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/color_helper.dart';
import '../helpers/interstitial_ad_helper.dart';
import '../models/video_list_data.dart';
import 'video_player.dart';
import '../widgets/rate_button.dart';
import '../widgets/share_button.dart';

class ListViewScreen extends StatefulWidget {
  final VideoListData videoListData;

  const ListViewScreen({super.key, required this.videoListData});

  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    InterstitialAdHelper.initialize();
    _setBackgroundColor();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _setBackgroundColor() {
    String backgroundColor = widget.videoListData.appBackgroundColor;
    _backgroundColor = ColorHelper.parseColor(backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
        backgroundColor: Colors.black54,
        actions: [
          AdButton(
            onPressed: () {
              InterstitialAdHelper.showInterstitialAd(() {});
            },
          ),
          ShareButton(onPressed: () {
            InterstitialAdHelper.showInterstitialAd(() {});
          }),
        ],
      ),
      body: Container(
        color: _backgroundColor,
        child: _buildVideoList(context),
      ),
    );
  }

  Widget _buildVideoList(BuildContext context) {
    return ListView.builder(
      itemCount: widget.videoListData.videos.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          color: const Color.fromARGB(255, 4, 56, 7),
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set the border radius
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 7),
            // textColor: Colors.white,
            title: Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                widget.videoListData.videos[index].videoTitle,
                style: Theme.of(context).textTheme.titleLarge,
                selectionColor: Colors.white,
              ),
            ),
            subtitle: Text(
              widget.videoListData.videos[index].videoDescription,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                widget.videoListData.videos[index].videoThumbnail,
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            onTap: () {
              _showInterstitialAd();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayScreen(
                    videoUrl: widget.videoListData.videos[index].videoUrl,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showInterstitialAd() {
    InterstitialAdHelper.showInterstitialAd(() {});
  }
}
