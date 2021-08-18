import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:meds_at_home/provider/app_provider.dart';
import 'package:meds_at_home/screens/home.dart';
import 'package:meds_at_home/screens/login.dart';
import 'package:meds_at_home/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
//import 'package:splashscreen/splashscreen.dart';
//import 'package:splashscreen/splashscreen.dart';
import 'provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),
  ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xff008db9)
        ),
        home:
        AnimatedSplashScreen(
          duration: 2000,
          splash: Image.asset('images/logo.png'),
          nextScreen: ScreensController(),
          splashTransition: SplashTransition.rotationTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: Colors.white,
          curve: Curves.bounceInOut,
        ),
      )));
}

class ScreensController extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
//    return SplashScreen();
    switch(user.status){
//      case Status.Uninitialized:
//        return SplashHomeScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}