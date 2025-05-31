import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sportsapp/data/models/onboarding_model.dart';
import 'package:sportsapp/screens/home_screen.dart';
import 'package:sportsapp/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  late Timer _timer; // Timer for auto-sliding

  // Onboarding page data
  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'Your Ultimate Sports Hub',
      description:
          'Track live scores, stats, and news for all your favorite teams and leagues in one place',
      image: 'assets/images/Soccer-bro.svg',
    ),
    OnboardingPage(
      title: 'Personalized Experience',
      description:
          'Get customized alerts for your teams, fantasy sports updates, and tailored content',
      image: 'assets/images/user-bro.svg',
    ),
    OnboardingPage(
      title: 'Join The Community',
      description:
          'Connect with fellow fans, debate match predictions, and celebrate victories together',
      image: 'assets/images/Rocket-bro.svg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    //* Start auto-sliding timer when widget initializes
    _startAutoSlide();
  }

  @override
  void dispose() {
    //* Cancel timer and dispose controller when widget is disposed
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  //* Method to start auto-sliding
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (controller.page == pages.length - 1) {
        //* If last page, loop back to first page
        controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      } else {
        controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }

  //* handle skip
  Future<void> _skipOnboarding() async {
    //* Change isFirstTime value
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 80.sp),
        child: PageView(
          controller: controller,
          children: pages.map((page) => buildPage(page)).toList(),
        ),
      ),
      bottomSheet: Container(
        height: 80.sp,
        color: const Color(0xFFFAFAFA),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip button that now handles the "Get Started" logic
              TextButton(
                onPressed: _skipOnboarding,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(left: 20.sp),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              // Page indicator
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: WormEffect(
                  activeDotColor: const Color(0xFF90C02A),
                  dotColor: const Color.fromARGB(255, 214, 214, 214),
                  dotHeight: 10.sp,
                  dotWidth: 10.sp,
                ),
                onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
              ),
              // Empty container to maintain layout (replaces the removed Next button)
              SizedBox(width: 60.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage(OnboardingPage page) {
    return Container(
      color: const Color(0xFFFAFAFA),
      padding: EdgeInsets.all(24.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            page.image,
            height: 250.sp,
            width: 250.sp,
          ),
          SizedBox(height: 40.sp),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 24.sp,
              color: const Color(0xffA1D336),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              page.description,
              style: TextStyle(
                fontSize: 16.sp,
                height: 1.5,
                color: const Color(0xff1E1E1E),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}