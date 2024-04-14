import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  late Future<List<Video>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = fetchVideos();
  }

  Future<List<Video>> fetchVideos() async {
    final response =
        await http.get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return List<Video>.from(parsed['datos'].map((x) => Video.fromJson(x)));
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: FutureBuilder<List<Video>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoItem(video: videos[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class Video {
  final String id;
  final String fecha;
  final String titulo;
  final String descripcion;
  final String link;

  Video({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    required this.link,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      fecha: json['fecha'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      link: json['link'],
    );
  }
}

class VideoItem extends StatelessWidget {
  final Video video;

  const VideoItem({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(video.link)!,
              flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          ),
          ListTile(
            title: Text(video.titulo),
            subtitle: Text(video.descripcion),
          ),
        ],
      ),
    );
  }
}
