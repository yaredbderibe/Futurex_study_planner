import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/utils/color_collections.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_feature_tour/flutter_feature_tour.dart';

class PomodoroTimerPage extends StatefulWidget {
  const PomodoroTimerPage({super.key});

  @override
  State<PomodoroTimerPage> createState() => _PomodoroTimerPageState();
}

class _PomodoroTimerPageState extends State<PomodoroTimerPage> {
  //variables
  static const int _focusDuration = 25 * 60; // 25 minutes in seconds
  static const int _breakDuration = 5 * 60; // 5 minutes in seconds
  int _remainingSeconds = _focusDuration;
  bool _isRunning = false; // Start paused by default
  bool _isFocusTime = true; // Start with focus time
  Timer? _timer;

  //instances
  final OnboardingService _onboardingService = OnboardingService();

  //global key
  final GlobalKey studyInfo = GlobalKey();
  final GlobalKey startInfo = GlobalKey();

  //functions
  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get _progress {
    final int currentDuration = _isFocusTime ? _focusDuration : _breakDuration;
    double progress = 1.0 - (_remainingSeconds / currentDuration);
    return progress.clamp(0.0, 1.0); // Ensure progress is within bounds
  }

  void _startTimer() {
    if (_isRunning) return; // Avoid duplicate timers

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _stopTimer();
          _toggleTimerMode(); // Switch between focus and break
        }
      });
    });
  }

  void _toggleTimerMode() {
    setState(() {
      _isFocusTime = !_isFocusTime;
      // _isRunning=true;
      _remainingSeconds = _isFocusTime ? _focusDuration : _breakDuration;
    });
    print(_isRunning);
    if (!_isRunning) _startTimer(); // Restart timer if it was running
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

  void _setupOnboarding() {
    _onboardingService.startOnboarding(context);
    _onboardingService
        .setAnalyticsCallback((String event, Map<String, dynamic> properties) {
      if (kDebugMode) {
        print('Analytics Event: $event, Properties: $properties');
      }
      // Implement your analytics tracking here
    });

    _onboardingService.addFeatureHighlightStep([
      FeatureHighlight(
        targetKey: studyInfo,
        title: 'Study',
        description:
            'This Study page uses the Pomodoro Technique for effective focus 25 min Focused study session 5 min Short break.',
        icon: Icons.timer_outlined,
        shape: HighlightShape.rectangle,
      ),
    ]);

    _onboardingService.addFeatureHighlightStep([
      FeatureHighlight(
        targetKey: startInfo,
        title: 'Start',
        description: 'Click to begin a 25-minute focused session.',
        icon: Icons.rocket_launch_outlined,
        shape: HighlightShape.rectangle,
      ),
    ]);
  }

  void _setTourTheme() {
    _onboardingService.setTheme(FeatureTourTheme(
      overlayColor: Colors.black54,
      highlightColor: Colors.blue,
      cardColor: Colors.grey[800] ?? Colors.grey,
      textColor: Colors.white,
      primaryColor: Colors.blue,
      titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyStyle: const TextStyle(fontSize: 16),
      buttonStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      cornerRadius: 10.0,
      highlightBorderWidth: 2.0,
    ));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupOnboarding();
      _setTourTheme();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: themeData.background,
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                  TextColor: themeData.primary,
                  FromTop: 10,
                  FromBottom: 10,
                  TextString: "Study Session",
                  FontSize: 25,
                  TextFontWeight: FontWeight.bold,
                ),
                Tooltip(
                  message:
                      'This Study page uses the Pomodoro Technique for effective focus 25 min Focused study session 5 min Short break.',
                  child: IconButton(
                    key: studyInfo,
                    onPressed: () {},
                    icon: Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            ReusableText(
              FromTop: 0,
              FromBottom: 50,
              TextString: _isFocusTime
                  ? 'Focus for 25 minutes'
                  : 'Take a break for 5 minutes',
              FontSize: 18,
              TextColor: themeData.onPrimary,
            ),
            SizedBox(height: 80),

            //
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 8.0,
              percent: _progress,
              circularStrokeCap: CircularStrokeCap.round,
              center: ReusableText(
                TextString: _formattedTime,
                FontSize: 48,
                TextColor: themeData.primary,
              ),
              progressColor: _isFocusTime ? Colors.blue : Colors.green,
              backgroundColor: Colors.blue.shade100,
            ),

            //
            SizedBox(height: 10),
            _isFocusTime
                ? _isRunning
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: reusableButtonContainer(context, "Pause",
                                    Colors.blue, Colors.white),
                              ),
                              Expanded(
                                child: reusableButtonContainer(context, 'Reset',
                                    Colors.white, Colors.black),
                              ),
                            ],
                          ),
                          reusableButtonContainer(context, 'Complete Early',
                              Colors.white, Colors.black)
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 40.0),
                          Container(
                            key: !_isRunning ? startInfo : null,
                            child: reusableButtonContainer(
                                context,
                                _isRunning ? 'Pause' : 'Start',
                                Colors.blue,
                                Colors.white),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      )
                : BreakTimeWidget()
          ],
        ),
      ),
    );
  }

  Widget reusableButtonContainer(
      BuildContext context, String content, Color contColor, Color txtColor) {
    return InkWell(
      onTap: () {
        if (content == "Reset") {
          _resetTimer();
        } else if (content == "Pause" || content == "Start") {
          _isRunning ? _stopTimer() : _startTimer();
        } else if (content == "Complete Early") {
          _toggleTimerMode(); // Switch to break early
        } else if (content == "Start New Session") {
          _resetTimer(); // Reset to focus time
          _startTimer();
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/index_page", (predicate) => true);
        }
      },
      child: Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        margin: EdgeInsets.only(top: 20, right: 3, left: 3),
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: contColor,
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content == "Pause"
                ? Icon(Icons.pause, color: Colors.white)
                : content == "Start"
                    ? Icon(Icons.play_arrow, color: Colors.white)
                    : content == "Complete Early"
                        ? Icon(Icons.check, color: Colors.blue)
                        : SizedBox(),
            SizedBox(width: 10),
            Center(
              child: ReusableText(
                TextColor: txtColor,
                FromRight: 10,
                TextString: content,
                FontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BreakTimeWidget() {
    return Column(
      children: [
        ReusableText(
          TextColor: ColorCollections.TeritiaryColor,
          FromTop: 10,
          FromBottom: 10,
          TextString: "Break Time!",
          FontSize: 25,
          TextFontWeight: FontWeight.bold,
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade100,
          ),
          child: Center(
            child: ReusableText(
              TextColor: Colors.blue,
              FromTop: 10,
              FromBottom: 10,
              TextString: "Do 5 Push-ups",
              FontSize: 20,
              TextFontWeight: FontWeight.bold,
            ),
          ),
        ),
        ReusableText(
          TextColor: ColorCollections.TeritiaryColor,
          FromTop: 10,
          FromBottom: 0,
          TextString: "Take a short break before your next session",
          FontSize: 15,
          TextFontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 20.0),
        reusableButtonContainer(
            context, 'Start New Session', Colors.blue, Colors.white),
        const SizedBox(height: 10.0),
        reusableButtonContainer(
            context, "Back To Dashboard", Colors.white, Colors.black54),
      ],
    );
  }
}
