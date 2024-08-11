import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart'; // Import the animate_do package
import 'package:intl/intl.dart';
import 'package:my_pitch/components/background_image.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String _username = '';
  List<Map<String, dynamic>> _matches = [];

  @override
  void initState() {
    super.initState();
  _loadData();
  }

  Future<void> _loadData() async {
    final authService = Get.find<AuthService>();
    final user = authService.currentUser;
    if (user != null) {
      try {
        final userData = await authService.fetchUserData(user.email!);
        if (userData != null) {
          setState(() {
            _username = userData['username'];
            _matches = _getMatches(); // Load the matches data
            _isLoading = false;
          });
        } else {
          Get.offNamed('/login');
        }
      } catch (error) {
        print('Error fetching user data: $error');
        Get.offNamed('/login');
      }
    } else {
      Get.offNamed('/login');
    }
  }

  List<Map<String, dynamic>> _getMatches() {
    final today = DateFormat('d MMM').format(DateTime.now());
    return [
      {
        "date": today,
        "day": "TODAY",
        "title": "Boys Varsity Football",
        "opponent": "AT Preparatory Spartans",
        "time": "7:30.PM",
        "isLive": true,
        "club1": "Riverton High",
        "club2": "Preparatory Spartans",
      },
      {
        "date": today,
        "day": "TODAY",
        "title": "Girls Varsity Soccer",
        "opponent": "VS Riverton High",
        "time": "8:00.PM",
        "isLive": true,
        "club1": "Central High",
        "club2": "Riverton High",
      },
      {
        "date": today,
        "day": "TODAY",
        "title": "Boys Varsity Basketball",
        "opponent": "AT Central High",
        "time": "9:30.PM",
        "isLive": true,
        "club1": "Bayside High",
        "club2": "Central High",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.find<AuthService>().currentUser;

    if (user == null) {
      Future.microtask(() => Get.offNamed('/login'));
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.accentPrimary,
          ),
        ),
      );
    }

    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: AppTheme.accentPrimary,
            ))
          : SafeArea(
              child: BackgroundImageWithGradient(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        delay: Duration(milliseconds: 100),
                        child: _buildHeader(),
                      ),
                      SizedBox(height: 10.0),
                      FadeInDown(
                        delay: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Hi 👋 $_username',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              height:
                                  55 / 45, // Line height relative to font size
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FadeInDown(
                          delay: Duration(milliseconds: 200),
                          child: ListView.builder(
                            itemCount: _matches.length,
                            itemBuilder: (context, index) {
                              final match = _matches[index];
                              return FadeInUp(
                                delay:
                                    Duration(milliseconds: 250 + (index * 100)),
                                child: _buildMatchCard(match),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.primaryDark,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Image.asset(
                'assets/logo.png', // Update with your logo asset path
                fit: BoxFit.contain,
                height: 30,
              ),
            ),
            IconButton(
              icon: Icon(Icons.logout, color: AppTheme.primaryLight),
              onPressed: () async {
                await Get.find<AuthService>().signOut();
                Get.offNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    return Card(
      color: AppTheme.secondaryGray,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match['day'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.primaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  match['date'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.primaryLight,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              "${match['club1']} VS ${match['club2']}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // SizedBox(height: 4.0),
            // Text(
            //   '${match['club1']} VS ${match['club2']}',
            //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //         color: AppTheme.primaryLight.withOpacity(0.7),
            //       ),
            // ),
            SizedBox(height: 4.0),
            Text(
              match['time'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryLight.withOpacity(0.7),
                  ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (match['isLive'])
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme
                            .accentPrimary, // Accent color for the border
                        width: 2.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(5.0), // Add border radius
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        'Live',
                        style: TextStyle(color: AppTheme.primaryLight),
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/game', arguments: {
                      'club1': match['club1'],
                      'club2': match['club2'],
                      'time': match['time'],
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Theme.of(context).hintColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Enter Dugout',
                    style: TextStyle(
                      color: AppTheme.primaryDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
