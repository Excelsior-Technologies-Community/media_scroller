import 'package:media_scroller/src/models/reel_data.dart';

class SampleReels {
  static List<ReelData> getReels() {
    return [
      ReelData(
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        username: 'nature_films',
        profileImage: 'https://i.pravatar.cc/100?img=12',
        caption: 'Beautiful nature animation 🎬 #nature #animation',
        likes: '1.3K',
        comments: '89',
        shares: '34',
        isVideo: true,
      ),
      ReelData(
        imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1080&h=1920&fit=crop',
        username: 'mountain_explorer',
        profileImage: 'https://i.pravatar.cc/100?img=33',
        caption: 'Top of the world! 🏔️ #mountains #adventure',
        likes: '2.1K',
        comments: '156',
        shares: '67',
        isVideo: false,
      ),
      ReelData(
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        username: 'creative_studio',
        profileImage: 'https://i.pravatar.cc/100?img=45',
        caption: 'Dream sequence ✨ #creative #art',
        likes: '3.4K',
        comments: '234',
        shares: '89',
        isVideo: true,
      ),
      ReelData(
        imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=1080&h=1920&fit=crop',
        username: 'nature_lover',
        profileImage: 'https://i.pravatar.cc/100?img=22',
        caption: 'Lost in nature 🌲 #forest #peace',
        likes: '1.8K',
        comments: '102',
        shares: '45',
        isVideo: false,
      ),
      ReelData(
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        username: 'adventure_seeker',
        profileImage: 'https://i.pravatar.cc/100?img=67',
        caption: 'Epic adventures await! 🔥 #adventure #explore',
        likes: '2.7K',
        comments: '178',
        shares: '92',
        isVideo: true,
      ),
      ReelData(
        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1080&h=1920&fit=crop',
        username: 'ocean_vibes',
        profileImage: 'https://i.pravatar.cc/100?img=15',
        caption: 'Ocean breeze and palm trees 🌴 #tropical #paradise',
        likes: '4.2K',
        comments: '267',
        shares: '134',
        isVideo: false,
      ),
    ];
  }
}