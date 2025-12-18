import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_scroller/src/data/sample_reels.dart';
import 'package:media_scroller/src/models/reel_data.dart';
import 'package:media_scroller/src/widgets/reel_item.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;
  final List<ReelData> reels = SampleReels.getReels();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.vertical,
        itemCount: reels.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
          HapticFeedback.lightImpact();
        },
        itemBuilder: (context, index) {
          return ReelItem(
            key: PageStorageKey(index),
            reelData: reels[index],
            isActive: currentPage == index,
          );
        },
      ),
    );
  }
}