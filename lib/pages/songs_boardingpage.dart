import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/others.dart';
import '../widgets/circle_playbutton.dart';
import '../widgets/rectangle_button.dart';

class SongBoard extends StatefulWidget {
  const SongBoard({
    super.key,
    required this.musicName,
    required this.musicSource,
    required this.imageSource,
  });

  final String musicName;
  final String musicSource;
  final String imageSource;

  @override
  State<SongBoard> createState() => _SongBoardState();
}

class _SongBoardState extends State<SongBoard> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    setAudio();
    // listening to player state
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    AssetSource source = AssetSource('musics/${widget.musicSource}');
    await player.play(source);
    player.setReleaseMode(ReleaseMode.loop);
  }

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
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/${widget.imageSource}',
                        width: constraints.maxWidth * 0.9, // Responsive image
                        height: 350,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      widget.musicName,
                      style: kLargeTextStyle,
                    ),
                    Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.deepPurple[200],
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await player.seek(position);
                        await player.resume();
                      },
                    ),
                    CirclePlayButton(isPlaying: isPlaying, player: player),
                    const SizedBox(
                      height: 120,
                    ),
                    RectangleButton(
                      onPressed: () async {
                        await player.stop();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "GO TO DASHBOARD",
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
