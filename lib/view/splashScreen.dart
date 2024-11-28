import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:bhagavad_gita/view/homePage.dart'; // Update with your home page path

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _textAnimation;
  late Animation<Color?> _textColorAnimation;

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _textAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Off-screen to top
      end: Offset.zero, // Final position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _textColorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.black,
    ).animate(_controller);

    _videoController = VideoPlayerController.network(
      'https://cdnl.iconscout.com/lottie/premium/preview-watermark/lord-krishna-5863584-4921684.mp4',
    )..initialize().then((_) {
        setState(() {
          _videoController.play();
          _videoController.setLooping(true);
        });
      });

    // Navigate to HomePage after the specified duration
    Timer(const Duration(seconds: 5), () {
      _navigateToHomePage();
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Video Player
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              height: 400, // Adjust the height as per your requirement
              child: _videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController),
                    )
                  : const Center(
                      child:
                          CircularProgressIndicator()), // Placeholder for video player before initialization
            ),
          ),

          // Animated Text
          SlideTransition(
            position: _textAnimation,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'श्रीमद् ',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _textColorAnimation.value,
                    ),
                    children: [
                      TextSpan(
                        text: 'भगवद्गीता',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _textColorAnimation.value == Colors.red
                              ? Colors.black
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
