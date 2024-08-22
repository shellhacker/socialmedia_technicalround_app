import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../domain/entities/main_model.dart';
import 'clip_status_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:socialmedia_technicalround_app/configs/theme.dart';
import 'package:socialmedia_technicalround_app/configs/colors.dart';

class VideoCard extends StatelessWidget {
  final Datum post;
  final int index;

  const VideoCard({required this.index, required this.post, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 630,
      margin: const EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FasLaughVideoPLayer(
                onChanged: (isPlaying) {
                  // log(index.toString());
                },
                videoUrl: post.cdnUrl),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            height: 375,
            width: 85,
            right: 0,
            top: 25,
            child: Transform.rotate(
              angle: 3.14,
              child: ClipPath(
                clipper: ClipStatusBar(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: ColoredBox(
                    color: AppColors.whiteColor.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 75,
            right: 20,
            child: Column(
              children: [
                ItemStatus(
                  icon: "assets/images/ic_heart.png",
                  text: "like",
                ),
                SizedBox(height: 10),
                ItemStatus(
                  icon: "assets/images/ic_message.png",
                  text: "comment",
                ),
                SizedBox(height: 10),
                ItemStatus(
                  icon: "assets/images/ic_bookmark.png",
                  text: "Save",
                ),
                SizedBox(height: 10),
                ItemStatus(
                  icon: "assets/images/ic_send.png",
                  text: "share",
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 18, right: 40, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          post.user.profilePictureCdn ??
                              post.user.profilePicture,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.account_circle_outlined),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        post.user.username,
                        style: AppTheme.whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  post.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: AppTheme.regular,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "wjesfhw",
                  style: AppTheme.whiteTextStyle.copyWith(
                    color: AppColors.greenColor,
                    fontSize: 12,
                    fontWeight: AppTheme.medium,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemStatus extends StatelessWidget {
  const ItemStatus({super.key, required this.icon, required this.text});
  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                scale: 2.3,
                image: AssetImage(icon),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: AppTheme.whiteTextStyle.copyWith(
            fontSize: 12,
            fontWeight: AppTheme.regular,
          ),
        ),
      ],
    );
  }
}

class FasLaughVideoPLayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onChanged;
  const FasLaughVideoPLayer(
      {Key? key, required this.onChanged, required this.videoUrl})
      : super(key: key);

  @override
  State<FasLaughVideoPLayer> createState() => _FasLaughVideoPLayerState();
}

class _FasLaughVideoPLayerState extends State<FasLaughVideoPLayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      _videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
