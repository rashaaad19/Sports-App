import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sportsapp/data/models/onboarding_model.dart';
import 'package:sportsapp/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  bool isLastPage = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 80.sp),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            //* Check if thee last page
            setState(() {
              isLastPage = index == pages.length - 1;
            });
          },
          children: pages.map((page) => buildPage(page)).toList(),
        ),
      ),
      bottomSheet:
          isLastPage
              ? Container(
                height: 80.sp,
                width: double.infinity,
                color: Color(0xFFFAFAFA),
                child: ElevatedButton(
                  onPressed: () async{
                    //* Check if it's user first time
                    final prefs=await SharedPreferences.getInstance();
                    prefs.setBool('isFirstTime', false);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) =>
                          false, 
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF90C02A), 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )
              : Container(
                height: 80.sp,
                color: Color(0xFFFAFAFA),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.jumpToPage(pages.length - 1);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(left: 20.sp),
                        ),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          activeDotColor: Color(0xFF90C02A),
                          dotColor: const Color.fromARGB(255, 214, 214, 214),
                          dotHeight: 10.sp,
                          dotWidth: 10.sp,
                        ),
                        onDotClicked:
                            (index) => controller.animateToPage(
                              index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (controller.page == pages.length - 1) {
                            print('Final page');
                            //* Navigate to home screen or login screen
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(right: 20.sp),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Color(0xFF90C02A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget buildPage(OnboardingPage page) {
    return Container(
      color: Color(0xFFFAFAFA),
      padding: EdgeInsets.all(24.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            page.image,
            height: 250.sp, // Adjust height as needed
            width: 250.sp, // Adjust width as needed
          ),
          SizedBox(height: 40.sp),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xffA1D336),
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
                color: Color(0xff1E1E1E),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
