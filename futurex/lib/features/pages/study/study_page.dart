import 'dart:async';
import 'package:flutter/material.dart';
import 'package:futurex/utils/color_collections.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PomodoroTimerPage extends StatefulWidget {
  const PomodoroTimerPage({super.key});

  @override
  State<PomodoroTimerPage> createState() => _PomodoroTimerPageState();
}

class _PomodoroTimerPageState extends State<PomodoroTimerPage> {
  static const int _focusDuration = 25 * 60; // 25 minutes in seconds
  static const int _breakDuration = 25 * 60; // 5 minutes in seconds
  int _remainingSeconds = _focusDuration;
  bool _isRunning = false;
  bool _isFocusTime = true; // Track focus or break time
  Timer? _timer;

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get _progress {
    // Calculate progress based on current focus/break duration
    final int currentDuration = _isFocusTime ? _focusDuration : _breakDuration;
    return 1.0 - (_remainingSeconds / currentDuration);
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _stopTimer();
          _startBreakTimer(); // Start break timer when focus time ends
        }
      });
    });
  }

  void _startBreakTimer() {
    setState(() {
      _isFocusTime = false; // Switch to break time
      _remainingSeconds = _breakDuration;
    });
    _startTimer(); // Reuse _startTimer to start the break timer
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _isFocusTime = true; // Reset to focus time
      _remainingSeconds = _focusDuration;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Study Session'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              _isFocusTime ? 'Focus for 25 minutes' : 'Take a break for 5 minutes',
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.left, // Aligned the text to the left
            ),
          ),
        ),
      ),
      
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 8.0,
              percent: _progress,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                _formattedTime,
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
              progressColor: _isFocusTime ? Colors.blue : Colors.green, // Change color based on focus/break
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.redAccent : Colors.blue, // Change color when running
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    _isRunning ? 'Pause' : 'Start',
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton( // Added Reset Button
              onPressed: _resetTimer,
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
