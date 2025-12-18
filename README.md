# MediaScroller
A beautiful, customizable Instagram-style reels/media scroller widget for Flutter with seamless video and image support, smooth animations, and haptic feedback.
* Vertical reel scrolling
* Video & image reels support
* Horizontal image carousel inside reels
* Animated action buttons (like, save, share)
* Haptic feedback
* Instagram-style user info UI

## ✨ Features
* 📱 Vertical Scrolling - Smooth, snap-to-page scrolling like Instagram Reels
* 🎥 Video Support - Automatic playback with play/pause controls
* 🖼️ Image Support - Mixed content with videos and images
* ❤️ Interactive Actions - Like, comment, share, and save buttons
* 👆 Haptic Feedback - Tactile response on every interaction
* 🎨 Smooth Animations - Elastic animations for likes and saves
* 📋 Expandable Menus - Slide-out action menus
* 👤 Social Features - Follow/unfollow functionality
* 🎯 Customizable - Use individual widgets or the complete screen
* ⚡ Performance Optimized - Lazy loading and efficient video management

## ✨ Preview
  ![screen-20251218-172553~3](https://github.com/user-attachments/assets/1bf53646-dd74-4ac1-ab15-5567a4ec579b)


---
## ✨ Installation
Add this to your package's pubspec.yaml file:
```
dependencies:
  media_scroller:
    path: ../media_scroller  # For local development
```
from git:
```
dependencies:
  media_scroller:
    git:
      url: https://github.com/yourusername/media_scroller.git  # Your github path
``` 
Then run:
```
flutter pub get
```
---
## 📁Project Structure
```
lib/
├─ media_scroller.dart
└─ src/
  ├─ data/
  │ └─ sample_reels.dart
  ├─ models/
  │ └─ reel_data.dart
  ├─ screens/
  │ └─ reels_screen.dart
  └─ widgets/
    ├─ reel_item.dart
    └─ action_button.dart
```
---
## ⚙️ Customization
* Change animations duration in reel_item.dart
* Replace SampleReels with API data
* Customize icons & colors easily
---

## Android
Add internet permission in android/app/src/main/AndroidManifest.xml:
```
<uses-permission android:name="android.permission.INTERNET"/>
```
---
## 🚀 Usage
1️⃣ Import
```
import 'package:media_scroller/media_scroller.dart';
```
2️⃣ Reels Screen
```
class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: MediaScroller(),
    );
  }
}
```
---

## 🧩 Reel Data Model
```
ReelData(
  videoUrl: 'https://example.com/video.mp4',
  username: 'travel_lover',
  profileImage: 'https://i.pravatar.cc/100',
  caption: 'Amazing sunset 🌅 #travel',
  likes: '1.3K',
  comments: '89',
  shares: '34',
  isVideo: true,
);
```
Image Reel Example
```
ReelData(
  imageUrls: [
    'https://images.unsplash.com/photo-1',
    'https://images.unsplash.com/photo-2',
  ],
  username: 'nature_world',
  profileImage: 'https://i.pravatar.cc/100?img=10',
  caption: 'Nature vibes 🌿',
  likes: '2.1K',
  comments: '140',
  shares: '60',
  isVideo: false,
);
```
---
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED **"AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
