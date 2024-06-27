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
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;
  late Animation<Offset> _textAnimation;

  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.red.shade50,
    ).animate(_controller);

    _textAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.0), // Off-screen to top
      end: Offset.zero, // Final position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHomePage();
      }
    });

    _videoController = VideoPlayerController.network(
      'https://cdnl.iconscout.com/lottie/premium/preview-watermark/lord-krishna-5863584-4921684.mp4', // Replace with your actual video URL
    )..initialize().then((_) {
      setState(() {});
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideTransition(
                  position: _textAnimation,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _colorAnimation.value ?? Colors.white,
                          _colorAnimation.value ?? Colors.red.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: FadeTransition(
                      opacity: _animation,
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SlideTransition(
                  position: _textAnimation,
                  child: RichText(
                    text: TextSpan(
                      text: 'श्रीमद् ',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'भगवद्गीता',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
