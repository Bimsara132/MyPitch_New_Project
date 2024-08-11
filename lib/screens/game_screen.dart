import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_pitch/components/background_image.dart';
import 'package:my_pitch/theme.dart';
import 'dart:async'; // Import for Timer

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool gameStarted = false;
  List<Map<String, String>> tags = [];
  final TextEditingController tagController = TextEditingController();
  DateTime gameStartTime = DateTime.now();
  String? selectedTeam;
 Timer ?_timer; // Timer for updating elapsed time
  late Duration elapsedTime = Duration.zero;

  late String club1;
  late String club2;
  late String time;

  @override
  void initState() {
    super.initState();

    // Safely retrieving arguments
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null &&
        arguments.containsKey('club1') &&
        arguments.containsKey('club2') &&
        arguments.containsKey('time')) {
      club1 = arguments['club1'] as String;
      club2 = arguments['club2'] as String;
      time = arguments['time'] as String;
    } else {
      // Handle the case where arguments are missing or incorrect
      club1 = 'Unknown Club 1';
      club2 = 'Unknown Club 2';
      time = '14:00 PM';
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startGame() {
    setState(() {
      gameStarted = true;
      gameStartTime = DateTime.now();
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime = DateTime.now().difference(gameStartTime);
      });
    });
  }

  void addTag() {
    final tag = tagController.text;
    if (tag.isNotEmpty && selectedTeam != null) {
      final gameTime = elapsedTime.inSeconds;
      final minutes = (gameTime / 60).floor();
      final seconds = gameTime % 60;

      // Format start time and date
      final formattedStartTime =
          DateFormat('h:mm a - d MMM').format(gameStartTime);

      setState(() {
        tags.add({
          'description': tag,
          'club': selectedTeam!,
          'startTime': formattedStartTime,
          'elapsedTime': '${minutes}m ${seconds}s',
        });
      });
      tagController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        foregroundColor: AppTheme.primaryLight,
        title: Image.asset(
          'assets/logo.png',
          height: 30,
          fit: BoxFit.contain,
        ),
      ),
      body: SafeArea(
        child: BackgroundImageWithGradient(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  FadeInDown(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      'Live Game',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildGameInfoCard(),
                  const SizedBox(height: 16),
                  if (!gameStarted) _buildStartGameButton(),
                  if (gameStarted) ...[
                    const SizedBox(height: 16.0),
                    _buildGameStartedInfo(), // New Widget for Game Start Info
                    const SizedBox(height: 16.0),
                    _buildTeamSelectionDropdown(),
                    const SizedBox(height: 10),
                    _buildTagDescriptionField(),
                    const SizedBox(height: 10),
                    _buildAddTagButton(),
                    const SizedBox(height: 20),
                    _buildTagsList(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameInfoCard() {
    return FadeInDown(
      delay: const Duration(milliseconds: 150),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppTheme
                .secondaryGray, 
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                club1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Text(
                'VS',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                club2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Start Time: $time',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartGameButton() {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: startGame,
        child: const Text(
          'Start Game',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).hintColor,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildGameStartedInfo() {
    final formattedGameStartTime =
        DateFormat('h:mm a - d MMM').format(gameStartTime);
    return FadeInDown(
      delay: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppTheme.secondaryGray,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Game is started!',
              style: TextStyle(
                color: AppTheme.accentPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppTheme.primaryLight),
                const SizedBox(width: 8),
                Text(
                  'Started at: $formattedGameStartTime',
                  style: TextStyle(color: AppTheme.primaryLight),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timer, color: AppTheme.primaryLight),
                const SizedBox(width: 8),
                Text(
                  'Elapsed Time: ${elapsedTime.inMinutes}m ${elapsedTime.inSeconds % 60}s',
                  style: TextStyle(color: AppTheme.primaryLight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamSelectionDropdown() {
    return FadeInDown(
      delay: const Duration(milliseconds: 250),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.secondaryGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        hint: const Text('Select Team',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        value: selectedTeam,
        items: <String>[club1, club2].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedTeam = newValue;
          });
        },
        dropdownColor: AppTheme.primaryDark,
        style: const TextStyle(color: Colors.white),
        isExpanded: true,
      ),
    );
  }

  Widget _buildTagDescriptionField() {
    return FadeInDown(
      delay: const Duration(milliseconds: 300),
      child: TextField(
        controller: tagController,
        cursorColor: AppTheme.accentPrimary,
        decoration: InputDecoration(
          labelText: 'Tag Description',
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: AppTheme.secondaryGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
            focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.accentPrimary,
                                    ),
                                  ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildAddTagButton() {
    return FadeInDown(
      delay: const Duration(milliseconds: 350),
      child: ElevatedButton(
        onPressed: addTag,
        child: const Text('Save'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).hintColor,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
Widget _buildTagsList() {
  return FadeInDown(
    delay: const Duration(milliseconds: 400),
    child: tags.isEmpty
        ? FadeInDown(
      delay: const Duration(milliseconds: 400),
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: AppTheme.secondaryGray.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'No tags added',
                style: TextStyle(
                  color: AppTheme.primaryLight.withOpacity(0.4), // Adjusted opacity
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final tag = tags.reversed.toList()[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryGray,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.flag, color: AppTheme.accentPrimary),
                          const SizedBox(width: 5),
                          Text(
                            tag['description']!,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.sports_soccer, color: AppTheme.primaryLight),
                          const SizedBox(width: 5),
                          Text(
                            'Club: ${tag['club']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: AppTheme.primaryLight),
                          const SizedBox(width: 5),
                          Text(
                            'Game Start: ${tag['startTime']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.timelapse, color: AppTheme.primaryLight),
                          const SizedBox(width: 5),
                          Text(
                            'Time Elapsed: ${tag['elapsedTime']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
  );
}


}
