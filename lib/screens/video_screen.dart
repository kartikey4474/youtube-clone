import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/data.dart';
import 'package:youtube_clone/screens/nav_screen.dart';
import 'package:youtube_clone/widgets/video_card.dart';
import 'package:youtube_clone/widgets/video_info.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read(miniPlayerControllerProvider)
          .state
          .animateToHeight(state: PanelState.MAX),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, watch, _) {
                    final selectedVideo = watch(selectedVideoProvider).state;
                    return SafeArea(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                selectedVideo!.thumbnailUrl,
                                height: 220.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () => context
                                    .read(miniPlayerControllerProvider)
                                    .state
                                    .animateToHeight(state: PanelState.MIN),
                              ),
                            ],
                          ),
                          const LinearProgressIndicator(
                            value: 0.4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red,
                            ),
                          ),
                          VideoInfo(video: selectedVideo),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final video = suggestedVideos[index];
                    return VideoCard(
                      video: video,
                      hasPadding: true,
                      onTap: () => _scrollController!.animateTo(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                    );
                  },
                  childCount: suggestedVideos.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
