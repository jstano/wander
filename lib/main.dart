import 'package:flutter/material.dart';

void main() {
  runApp(const WanderApp());
}

class WanderApp extends StatelessWidget {
  const WanderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanderBooks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a purple toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme: .fromSeed(seedColor: Colors.green),
      // ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> onboardingPages = [
    OnboardingPageData(
      title: 'Welcome to WanderBooks',
      description: 'Your Personal Journey.\nBound Digitally',
      imagePath: 'assets/images/page-1.png',
      backgroundColor: const Color(0xFFEAE3DB), // Your tab background color
    ),
    OnboardingPageData(
      title: 'Track Every Adventure',
      description: 'Log countries, cities &\nattractions with ease',
      imagePath: 'assets/images/page-2.png',
      // Replace with your actual image path
      backgroundColor: const Color(0xFFEAE3DB),
    ),
    OnboardingPageData(
      title: 'Relive Your Memories',
      description: 'Automatic digital travel books\nwith photos, notes & maps',
      imagePath: 'assets/images/page-3.png',
      // Replace with your actual image path
      backgroundColor: const Color(0xFFEAE3DB),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Or a light grey similar to your mockup background
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPage(data: onboardingPages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle Skip logic
                    print('Skip tapped');
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    onboardingPages.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                _currentPage == onboardingPages.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          // Handle Get Started/Login logic
                          print('Get Started tapped');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          // Your primary accent color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          // Your primary accent color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.blueAccent
            : Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingPageData {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  OnboardingPageData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This stack creates the overlapping effect for the image
            Stack(
              alignment: Alignment.center,
              children: [
                // Background "tab" shape
                Container(
                  height:
                      MediaQuery.of(context).size.width *
                      0.7, // Adjust size as needed
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: data.backgroundColor, // Use the extracted hex value
                    borderRadius: BorderRadius.circular(
                      40,
                    ), // More rounded corners
                  ),
                ),
                // Oval image container (simulating the oval mask)
                Container(
                  width:
                      MediaQuery.of(context).size.width *
                      0.6, // Smaller than background
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(80), // More oval shape
                    image: DecorationImage(
                      image: AssetImage(data.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
