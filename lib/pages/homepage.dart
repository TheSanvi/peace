import 'package:flutter/material.dart';
import 'package:meditation_app/widgets/rectangle_button.dart';
import '../utils/others.dart';
import 'dash_boardpage.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/meditation.png",
                      width: constraints.maxWidth * 0.6, // Responsive image
                      height: constraints.maxHeight * 0.3,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "Time to meditate",
                      style: kLargeTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "Take a breath,\nand ease your mind",
                        style: kMeduimTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    RectangleButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      ),
                      child: Text(
                        "Let's get started",
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}