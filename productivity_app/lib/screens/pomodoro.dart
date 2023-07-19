import 'package:flutter/material.dart';
import 'package:productivity_app/utils/styles.dart';
import 'dart:async';
import '../utils/header.dart';
import 'package:audioplayers/audioplayers.dart';

class Pomo extends StatefulWidget {
  const Pomo({super.key});

  @override
  State<Pomo> createState() => _PomoState();
}

class _PomoState extends State<Pomo> {
  int seconds = 0;
  int minutes = 25;
  bool isPlaying = false;
  bool isPaused = false;
  bool isFocus = true;
  Timer? _timer;

  final player = AudioPlayer();

//Switch from Focus mode to Fun mode or vice-versa
  void pomoSwitch(bool isFocused) {
    String mode = isFocused ? "Focus" : "Fun";
    showDialog(
        context: context,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: const Text("Timer's Up"),
            content: SingleChildScrollView(
                child: Text("Start the timer to $mode mode")),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    if (mode == "Fun") {
                      setState(() {
                        minutes = 5;
                        seconds = 0;
                      });
                    } else {
                      setState(() {
                        minutes = 25;
                        seconds = 0;
                      });
                    }
                    player.stop();
                    startCountDown();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPlaying = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  startCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        isPaused = false;
        isPlaying = true;
      });
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else if (seconds <= 0 && minutes != 0) {
        setState(() {
          seconds = 59;
          minutes--;
        });
      } else {
        isPaused = false;
        await player.setSource(AssetSource('audios/alarm.mp3'));
        await player.resume();
        // await player.play();
        timer.cancel();
        setState(() {
          isFocus = !isFocus;
        });
        pomoSwitch(isFocus);
      }
    });
  }

  void stopCountDown() {
    _timer?.cancel();
    setState(() {
      seconds = 0;
      minutes = 2;
      isPlaying = false;
      isPaused = false;
    });
  }

  Widget pomoBtn(String data, Color color) {
    return Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
          child: Text(
        data,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, const Text("PomoDoro"), false),
      backgroundColor: Colors.deepPurple.shade100,
      body: Column(children: [
        const SizedBox(height: 100),
        Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.deepPurple.shade300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  minutes.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text(
                  ':',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  seconds.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Text(
          isFocus ? 'F O C U S   T I M E' : 'F U N   T I M E',
          style: const TextStyle(fontSize: 36),
        ),
        const SizedBox(
          height: 60,
        ),
        // If the timer is paused, it displays Play and Stop button
        (!isPlaying && isPaused)
            ? Column(
                children: [
                  GestureDetector(
                    onTap: startCountDown,
                    child: pomoBtn('Play', Styles.greenColor),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: stopCountDown,
                    child: pomoBtn('Stop', Styles.redColor),
                  ),
                ],
              )
            // If the timer is playing, it displays Pause and Stop button
            : (isPlaying && !isPaused)
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _timer?.cancel();
                          setState(() {
                            isPaused = true;
                            isPlaying = false;
                          });
                        },
                        child: pomoBtn('Pause', Colors.deepPurple.shade400),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: stopCountDown,
                        child: pomoBtn('Stop', Styles.redColor),
                      ),
                    ],
                  )
                // If the timer is not playing at all, it displays Play button
                : (!isPlaying)
                    ? GestureDetector(
                        onTap: startCountDown,
                        child: pomoBtn('Play', Styles.greenColor),
                      )
                    // This condition will never be reached. But just in case, I've added a error msg
                    : const Text('Error')
      ]),
    );
  }
}
