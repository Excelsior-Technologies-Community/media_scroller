import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:media_scroller/src/models/reel_data.dart';
import 'package:media_scroller/src/widgets/action_button.dart';
import 'package:media_scroller/src/widgets/menu_item.dart';

class ReelItem extends StatefulWidget {
  final ReelData reelData;
  final bool isActive;

  const ReelItem({Key? key, required this.reelData, required this.isActive})
    : super(key: key);

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> with TickerProviderStateMixin {
  bool isLiked = false;
  bool isSaved = false;
  bool isMenuExpanded = false;
  bool isFollowing = false;
  bool isPaused = false;

  VideoPlayerController? videoController;
  bool isVideoInitialized = false;
  bool isVideoLoading = false;

  late AnimationController likeController;
  late AnimationController saveController;
  late AnimationController menuController;

  late Animation<double> likeAnimation;
  late Animation<double> saveAnimation;
  late Animation<Offset> menuSlideAnimation;
  late Animation<double> menuFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    if (widget.reelData.isVideo && widget.isActive) {
      _initializeVideo();
    }
  }

  void _initializeAnimations() {
    likeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    likeAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: likeController, curve: Curves.elasticOut),
    );

    saveController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    saveAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: saveController, curve: Curves.elasticOut),
    );

    menuController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    menuSlideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: menuController, curve: Curves.easeOut));

    menuFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: menuController, curve: Curves.easeOut));
  }

  Future<void> _initializeVideo() async {
    if (widget.reelData.videoUrl == null ||
        isVideoLoading ||
        videoController != null)
      return;

    setState(() {
      isVideoLoading = true;
    });

    try {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.reelData.videoUrl!),
      );

      await videoController!.initialize();

      if (mounted) {
        setState(() {
          isVideoInitialized = true;
          isVideoLoading = false;
        });

        if (widget.isActive) {
          videoController!.play();
          videoController!.setLooping(true);
        }
      }
    } catch (e) {
      print('Error initializing video: $e');
      if (mounted) {
        setState(() {
          isVideoLoading = false;
          isVideoInitialized = false;
        });
      }
    }
  }

  @override
  void didUpdateWidget(ReelItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        if (widget.reelData.isVideo &&
            !isVideoInitialized &&
            !isVideoLoading) {
          _initializeVideo();
        } else if (isVideoInitialized && videoController != null) {
          videoController!.play();
          setState(() {
            isPaused = false;
          });
        }
      } else {
        if (videoController != null && isVideoInitialized) {
          videoController!.pause();
        }
      }
    }
  }

  @override
  void dispose() {
    likeController.dispose();
    saveController.dispose();
    menuController.dispose();
    videoController?.dispose();
    super.dispose();
  }

  void _vibrate() {
    HapticFeedback.lightImpact();
  }

  void _handleLike() {
    _vibrate();
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      likeController.forward().then((_) => likeController.reverse());
    }
  }

  void _handleSave() {
    _vibrate();
    setState(() {
      isSaved = !isSaved;
    });
    if (isSaved) {
      saveController.forward().then((_) => saveController.reverse());
    }
  }

  void _toggleMenu() {
    _vibrate();
    setState(() {
      isMenuExpanded = !isMenuExpanded;
    });
    if (isMenuExpanded) {
      menuController.forward();
    } else {
      menuController.reverse();
    }
  }

  void _handleAction(String action) {
    _vibrate();
    _toggleMenu();
    print('Action: $action');
  }

  void _handleFollow() {
    _vibrate();
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void _togglePlayPause() {
    if (!widget.reelData.isVideo ||
        !isVideoInitialized ||
        videoController == null)
      return;

    _vibrate();
    setState(() {
      isPaused = !isPaused;
    });

    if (isPaused) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.reelData.isVideo ? _togglePlayPause : null,
      child: Stack(
        children: [
          _buildMediaContent(),
          _buildPlayPauseIcon(),
          _buildGradientOverlay(),
          _buildBottomInfo(),
          _buildActionBar(),
          _buildTopAppBar(),
        ],
      ),
    );
  }

  Widget _buildMediaContent() {
    return Positioned.fill(
      child: widget.reelData.isVideo
          ? (isVideoInitialized && videoController != null
                ? Center(
                    child: AspectRatio(
                      aspectRatio: videoController!.value.aspectRatio,
                      child: VideoPlayer(videoController!),
                    ),
                  )
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ))
          : Image.network(
              widget.reelData.imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: Icon(Icons.image, size: 100, color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildPlayPauseIcon() {
    if (!widget.reelData.isVideo || !isPaused || !isVideoInitialized) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 48),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Positioned(
      left: 16,
      right: 80,
      bottom: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileInfo(),
          const SizedBox(height: 12),
          _buildCaption(),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
            image: DecorationImage(
              image: NetworkImage(widget.reelData.profileImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          widget.reelData.username,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: _handleFollow,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: isFollowing ? Colors.grey : Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isFollowing ? 'Following' : 'Follow',
              style: TextStyle(
                color: isFollowing ? Colors.grey : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaption() {
    return Text(
      widget.reelData.caption,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildActionBar() {
    return Positioned(
      right: 12,
      bottom: 20,
      child: Column(
        children: [
          // _buildProfileWithAddButton(),
          const SizedBox(height: 24),
          ActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            count: widget.reelData.likes,
            onTap: _handleLike,
            color: isLiked ? const Color(0xFFFF4D67) : Colors.white,
            animation: likeAnimation,
          ),
          const SizedBox(height: 24),
          ActionButton(
            icon: Icons.mode_comment_outlined,
            count: widget.reelData.comments,
            onTap: () {
              _vibrate();
              print('Comment tapped');
            },
          ),
          const SizedBox(height: 24),
          ActionButton(
            icon: Icons.send,
            count: widget.reelData.shares,
            onTap: () {
              _vibrate();
              print('Share tapped');
            },
          ),
          const SizedBox(height: 24),
          _buildMoreMenu(),
          const SizedBox(height: 24),
          ActionButton(
            icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
            count: '',
            onTap: _handleSave,
            animation: saveAnimation,
          ),
        ],
      ),
    );
  }

  // Widget _buildProfileWithAddButton() {
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       Container(
  //         width: 48,
  //         height: 48,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(color: Colors.white, width: 2),
  //           image: DecorationImage(
  //             image: NetworkImage(widget.reelData.profileImage),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //       // if (!_isFollowing)
  //       //   Positioned(
  //       //     bottom: -4,
  //       //     left: 0,
  //       //     right: 0,
  //       //     child: Center(
  //       //       child: GestureDetector(
  //       //         onTap: _handleFollow,
  //       //         child: Container(
  //       //           width: 24,
  //       //           height: 24,
  //       //           decoration: const BoxDecoration(
  //       //             color: Color(0xFFFF4D67),
  //       //             shape: BoxShape.circle,
  //       //           ),
  //       //           child: const Icon(Icons.add, color: Colors.white, size: 16),
  //       //         ),
  //       //       ),
  //       //     ),
  //       //   ),
  //     ],
  //   );
  // }

  Widget _buildMoreMenu() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ActionButton(icon: Icons.more_vert, count: '', onTap: _toggleMenu),
        if (isMenuExpanded)
          Positioned(
            right: 60,
            top: -8,
            child: GestureDetector(
              onTap: () {},
              child: SlideTransition(
                position: menuSlideAnimation,
                child: FadeTransition(
                  opacity: menuFadeAnimation,
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MenuItem(
                          title: 'Report',
                          onTap: () => _handleAction('report'),
                        ),
                        const Divider(height: 1, color: Colors.grey),
                        MenuItem(
                          title: 'Not Interested',
                          onTap: () => _handleAction('not_interested'),
                        ),
                        const Divider(height: 1, color: Colors.grey),
                        MenuItem(
                          title: 'About this account',
                          onTap: () => _handleAction('about'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  print('Camera tapped');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
