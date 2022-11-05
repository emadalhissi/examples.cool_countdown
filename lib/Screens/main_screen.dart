import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/my_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  bool isPlaying = false;

  String countText() {
    Duration count = animationController.duration! * animationController.value;
    return animationController.isDismissed
        ? '${animationController.duration!.inHours}:${(animationController.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(animationController.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    animationController.addListener(() {
      if (animationController.isAnimating) {
        setState(() {
          progress = animationController.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff273f4f),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: CircularProgressIndicator(
                color: const Color(0xff64dba8),
                value: progress,
                strokeWidth: 3,
              ),
            ),
            SizedBox(
              width: 309,
              height: 309,
              child: CircularProgressIndicator(
                color: const Color(0xffcf76df),
                value: progress,
                strokeWidth: 3,
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => Text(
                countText(),
                style: const TextStyle(
                  color: Color(0xffa2f9ca),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyButton(
            icon: isPlaying ? Icons.pause : Icons.play_arrow,
            onTap: () {
              if (animationController.isAnimating) {
                animationController.stop();
                setState(() {
                  isPlaying = false;
                });
              } else {
                animationController.reverse(
                    from: animationController.value == 0
                        ? 1.0
                        : animationController.value);
                setState(() {
                  isPlaying = true;
                });
              }
            },
          ),
          MyButton(
            icon: Icons.stop,
            onTap: () {
              animationController.reset();
              setState(() {
                isPlaying = false;
              });
            },
          ),
        ],
      ),
    );
  }
}
