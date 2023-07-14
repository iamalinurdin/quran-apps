import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/data/providers/audio_provider.dart';
import 'package:quran_app/utils/utils.dart';
import 'package:quran_app/widgets/buffer_slider_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class VerseItem extends StatefulWidget {
  final Map<String, dynamic> verse;

  const VerseItem({super.key, required this.verse});

  @override
  State<VerseItem> createState() => _VerseItemState();
}

class _VerseItemState extends State<VerseItem> {
  bool isPlaying = false;
  late final AudioPlayer audioPlayer;
  late final Source source;
  late Duration position = Duration.zero;
  late Duration duration = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    final provider = context.read<AudioProvider>();
    audioPlayer = AudioPlayer();
    source = UrlSource(widget.verse['audio']['01']);
    // source = UrlSource('https://equran.nos.wjv-1.neo.id/audio-partial/Abdullah-Al-Juhany/001001.mp3');
    audioPlayer.setSource(source);

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (!mounted) return;

      setState(() {
        isPlaying = event == PlayerState.playing;
      });

      if (event == PlayerState.stopped) {
        setState(() {
          position = Duration.zero;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((event) {
      if (!mounted) return;

      setState(() {
        duration = event;
      });
    });

    audioPlayer.onPositionChanged.listen((event) {
      if (!mounted) return;

      setState(() {
        position = event;
      });
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (!mounted) return;

      setState(() {
        position = Duration.zero;
        isPlaying = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                widget.verse['teksArab'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(widget.verse['teksLatin']),
            const SizedBox(height: 8),
            Text(
              widget.verse['teksIndonesia'],
              style: const TextStyle(
                fontSize: 16
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    if (isPlaying) {
                      audioPlayer.pause();
                    } else {
                      audioPlayer.play(source);
                    }
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_circle), 
                  label: Text(isPlaying ? 'Jeda' : 'Putar')
                ),
                if (isPlaying)
                  TextButton.icon(
                    onPressed: () => audioPlayer.stop(),
                    icon: const Icon(Icons.stop), 
                    label: const Text('Berhenti')
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (isPlaying)
              BufferSliderController(
                currentValue: position.inSeconds.toDouble(),
                maxText: durationToTimeString(duration),
                minText: durationToTimeString(position),
                maxValue: duration.inSeconds.toDouble(),
                onChanged: (value) async {
                  final newPosition = Duration(seconds: value.toInt());

                  await audioPlayer.seek(newPosition);
                  await audioPlayer.resume();
                },
              ),
          ],
        ),
      ),
    );
  }
}