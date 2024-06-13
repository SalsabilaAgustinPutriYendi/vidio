import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/vidio_model.dart';
import 'list_vidio.dart';
 // Ensure correct import path for VideoPlayerPage

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  List<Datum> _videoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVideoData();
  }

  Future<void> _fetchVideoData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.169.194/lat_vidio/vidio.php'));

      if (response.statusCode == 200) {
        final modelVideo = modelVideoFromJson(response.body);
        if (modelVideo.isSuccess && modelVideo.data.isNotEmpty) {
          setState(() {
            _videoList = modelVideo.data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load video data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching video data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToVideoPlayerPage(String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Video'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _videoList.length,
        itemBuilder: (context, index) {
          final video = _videoList[index];
          return GestureDetector(
            onTap: () {
              _navigateToVideoPlayerPage('http://192.168.169.194/lat_vidio/vidio/${video.vidio}');
            },
            child: Card(
              margin: const EdgeInsets.all(16.0),
              child: ListTile(
                leading: const Icon(Icons.play_circle),
                title: Text(video.judul),
                subtitle: Text(video.deskripsi), // Display description below title
              ),
            ),
          );
        },
      ),
    );
  }
}
