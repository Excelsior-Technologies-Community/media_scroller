class ReelData {
  final String? imageUrl;
  final String? videoUrl;
  final String username;
  final String profileImage;
  final String caption;
  final String likes;
  final String comments;
  final String shares;
  final bool isVideo;

  ReelData({
    this.imageUrl,
    this.videoUrl,
    required this.username,
    required this.profileImage,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isVideo,
  });
}