import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({Key? key}) : super(key: key);

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Khởi tạo video mặc định
    const initialVideoUrl = "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
    final videoId = YoutubePlayer.convertUrlToId(initialVideoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  void _playVideo() {
    if (_urlController.text.isNotEmpty) {
      final videoId = YoutubePlayer.convertUrlToId(_urlController.text);
      if (videoId != null) {
        // Tạo một controller mới để phát video mới
        final newController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true, // Tự động phát video mới
            mute: false,
          ),
        );

        // Hủy controller cũ và cập nhật bằng controller mới
        setState(() {
          _controller.dispose();
          _controller = newController;
        });
      } else {
        // Hiển thị thông báo lỗi nếu link không hợp lệ
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Link YouTube không hợp lệ')),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trình phát video YouTube'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Nhập link YouTube',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _playVideo,
                child: const Text('Xem Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
