import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'app_network_image.dart';
import 'link_preview.dart';

final _youtubeId = RegExp(
  r'^(?:(?:https?:)?\/\/)?(?:www\.|m\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?|shorts)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
);

/// web `VideoEmbed.tsx` 의 `getYoutubeVideoId`. YouTube 링크가 아니면 null.
String? youtubeVideoId(String url) => _youtubeId.firstMatch(url)?.group(1);

/// 아이템 링크. YouTube 면 [VideoEmbed], 아니면 [LinkPreview] (web `RankList.tsx` EmbedComponent).
/// web 은 Vimeo 도 iframe 으로 넣지만 앱은 PLAN §6 대로 YouTube 만 플레이어로 띄운다.
class ItemLinkEmbed extends StatelessWidget {
  const ItemLinkEmbed({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final videoId = youtubeVideoId(url);
    if (videoId == null) return LinkPreview(url: url);
    return VideoEmbed(videoId: videoId);
  }
}

/// YouTube 임베드. 목록에 WebView 가 여러 개 생기지 않도록 썸네일을 먼저 보이고,
/// 누르면 `youtube_player_iframe` 플레이어로 바꾼다.
class VideoEmbed extends StatefulWidget {
  const VideoEmbed({super.key, required this.videoId});

  final String videoId;

  @override
  State<VideoEmbed> createState() => _VideoEmbedState();
}

class _VideoEmbedState extends State<VideoEmbed> {
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  void _play() {
    setState(() {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: widget.videoId,
        autoPlay: true,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: controller != null
              ? YoutubePlayer(controller: controller)
              : GestureDetector(
                  key: const Key('videoEmbed.thumbnail'),
                  onTap: _play,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppNetworkImage(
                        url:
                            'https://img.youtube.com/vi/${widget.videoId}/hqdefault.jpg',
                      ),
                      const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          size: 56,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
